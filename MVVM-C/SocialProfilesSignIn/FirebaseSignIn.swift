import Firebase

class FirebaseSignIn {
    
    private var googleSignIn: GoogleSingIn?
    private var facebookSignIn: FacebookSignIn?
    private var appleSignIn: AppleSignIn?
    private var twitterSignIn: TwitterSignIn?
    private var currentController: UIViewController?
    weak var delegate: FireBaseSignInDelegate?

    init(viewController: UIViewController) {
        print("FirebaseSignIn InIt")
        currentController = viewController
    }
    
    deinit {
        print("FirebaseSignIn De-InIt")
    }
}

extension FirebaseSignIn: FirebaseProtocol {
    
    func signIn(signInType: SocialSignInType) {
        
        switch signInType {
            case .google:
                singInWithGoogle()
            case .apple:
                singInWithApple()
            case .facebook:
                singInWithFacebook()
            case .twitter:
                singInWithTwitter()
            case .microsoft, .github:
                developmentInProgress()
        }
    }
    
    static func signOut() throws {
        socialLogout()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Keychain<SocialSignInType>.clearData(key: FirebaseKeys.signInType.rawValue)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private static func socialLogout() {
        if let signInData = Keychain<Data>.retriveData(key: FirebaseKeys.signInType.rawValue), let signInType = try? JSONDecoder().decode(SocialSignInType.self, from: signInData) {
            switch signInType {
                case .google:
                    GoogleSingIn.signOut()
                case .facebook:
                    FacebookSignIn.signOut()
                case .twitter:
                    TwitterSignIn.signOut()
                default:
                    break
            }
        }
    }
    
    static var userExists: Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    static var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
}

private extension FirebaseSignIn {
    
    func singInWithGoogle() {
        googleSignIn = GoogleSingIn(controller: self.currentController)
        googleSignIn?.delegate = self
        googleSignIn?.signIn()
    }
    
    func singInWithApple() {
        appleSignIn = AppleSignIn(controller: self.currentController)
        appleSignIn?.delegate = self
        appleSignIn?.signIn()
    }
    
    func singInWithFacebook() {
        facebookSignIn = FacebookSignIn(controller: self.currentController)
        facebookSignIn?.delegate = self
        facebookSignIn?.signIn()
    }
    
    func singInWithTwitter() {
        twitterSignIn = TwitterSignIn(controller: self.currentController)
        twitterSignIn?.delegate = self
        twitterSignIn?.signIn()
    }
    
    func developmentInProgress() {
        delegate?.signInFailure("Development In-Progress")
    }
}

extension FirebaseSignIn: SocialSignInDelegate {
    
    func signInSuccess(credential: AuthCredential, signInType: SocialSignInType) {
        LoadingIndicator.shared.loading(step: .start(animate: true))
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            LoadingIndicator.shared.loading(step: .end)
            if error == nil {
                Keychain.storeData(value: signInType, key: FirebaseKeys.signInType.rawValue)
                self?.delegate?.signInSuccess()
            } else {
                self?.delegate?.signInFailure(error?.localizedDescription ?? "Something went wrong with social sign = \(signInType.rawValue)")
            }
        }
    }
    
    func signInFailure(_ error: String) {
        delegate?.signInFailure(error)
    }
}
