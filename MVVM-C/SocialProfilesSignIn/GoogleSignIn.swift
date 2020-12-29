import GoogleSignIn
import Firebase

class GoogleSingIn: NSObject {
    
    private var currentController: UIViewController?
    weak var delegate: SocialSignInDelegate?

    init(controller: UIViewController? = nil) {
        print("GoogleSingIn InIt")
        super.init()
        currentController = controller
        setup()
    }
    
    deinit {
        print("GoogleSingIn de-InIt")
    }
}

extension GoogleSingIn: GoogleSignInProtocol {
    
    static func config() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    
    static func handleUrl(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func setup() {
        GIDSignIn.sharedInstance()?.presentingViewController = currentController
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func signIn() {
        if GIDSignIn.sharedInstance()?.hasPreviousSignIn() == false {
            GIDSignIn.sharedInstance()?.signIn()
        }
    }
    
    static func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
}

extension GoogleSingIn: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        //handle sign-in errors
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                delegate?.signInFailure(GoogleSignInMessages.noUserExists.rawValue)
            } else {
                delegate?.signInFailure(error.localizedDescription)
            }
            return
        }
        
        // Get credential object using Google ID token and Google access token
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        // Authenticate with Firebase using the credential object
        LoadingIndicator.shared.loading(step: .start(animate: true))
        FirebaseSignIn.signIn(credential: credential) { [weak self] (authResult, error) in
            if let error = error {
                self?.delegate?.signInFailure(error.localizedDescription)
            } else {
                print(authResult?.user ?? GoogleSignInMessages.userFailure.rawValue)
                LoadingIndicator.shared.loading(step: .end)
                self?.delegate?.signInSuccess()
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        GIDSignIn.sharedInstance()?.disconnect()
        guard let errorMsg = error else { return }
        delegate?.signInFailure(errorMsg.localizedDescription)
    }
}

