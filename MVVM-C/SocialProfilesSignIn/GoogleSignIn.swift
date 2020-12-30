import GoogleSignIn
import Firebase

class GoogleSingIn: NSObject {
    
    private var viewController: UIViewController?
    weak var delegate: SocialSignInDelegate?

    init(viewController: UIViewController? = nil) {
        print("GoogleSingIn InIt")
        super.init()
        self.viewController = viewController
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
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
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
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                delegate?.signInFailure(GoogleSignInMessages.noUserExists.rawValue)
            } else {
                delegate?.signInFailure(error.localizedDescription)
            }
            return
        }
        
        guard let authentication = user.authentication else {
            delegate?.signInFailure("user.authentication failure")
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        delegate?.signInSuccess(credential: credential, signInType: .google)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        GIDSignIn.sharedInstance()?.disconnect()
        guard let errorMsg = error else { return }
        delegate?.signInFailure(errorMsg.localizedDescription)
    }
}

