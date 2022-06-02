import Firebase
import UIKit
import ReusableComponentsSwift

open class FirebaseSignIn {
    
    private var googleSignIn: GoogleSingIn?
    private var facebookSignIn: FacebookSignIn?
    private var appleSignIn: AppleSignIn?
    private var twitterSignIn: TwitterSignIn?
    private weak var delegate: FireBaseSignInDelegate?
    private var viewController: UIViewController? {
        get {
            return UIWindow.topViewController
        }
    }

    init() { print("FirebaseSignIn InIt") }
    
    deinit { print("FirebaseSignIn De-InIt") }
}

extension FirebaseSignIn: FirebaseProtocol {
    
    func signIn(signInType: SocialSignInType,
                delgate: FireBaseSignInDelegate) {
        self.delegate = delgate
        
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
        socialProfileLogout()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Keychain<SocialSignInType>.clearData(key: FirebaseKeys.signInType.rawValue)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private static func socialProfileLogout() {
        if let signInData = Keychain<Data>.retriveData(key: FirebaseKeys.signInType.rawValue),
           let signInType = try? JSONDecoder().decode(SocialSignInType.self,
                                                      from: signInData) {
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
        googleSignIn = GoogleSingIn(viewController: self.viewController,
                                    delegate: self)
        googleSignIn?.signIn()
    }
    
    func singInWithApple() {
        appleSignIn = AppleSignIn(viewController: self.viewController,
                                  delegate: self)
        appleSignIn?.signIn()
    }
    
    func singInWithFacebook() {
        facebookSignIn = FacebookSignIn(viewController: self.viewController,
                                        delegate: self)
        facebookSignIn?.signIn()
    }
    
    func singInWithTwitter() {
        twitterSignIn = TwitterSignIn(viewController: self.viewController,
                                      delegate: self)
        twitterSignIn?.signIn()
    }
    
    func developmentInProgress() {
        delegate?.signInFailure("Development In-Progress")
    }
}

extension FirebaseSignIn: SocialProfilesSignInDelegate {
    
    func signInSuccess(credential: AuthCredential,
                       signInType: SocialSignInType) {
        
        UIWindow.showLoading(steps: .start(animate: true))
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            UIWindow.showLoading(steps: .end)
            if error == nil {
                Keychain.storeData(value: signInType,
                                   key: FirebaseKeys.signInType.rawValue)
                self?.delegate?.signInSuccess()
            } else {
                self?.delegate?.signInFailure(error?.localizedDescription ?? "Something went wrong with social signIn = \(signInType.rawValue)")
            }
        }
    }
    
    func signInFailure(_ error: String) {
        delegate?.signInFailure(error)
    }
}
