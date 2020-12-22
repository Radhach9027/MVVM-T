import GoogleSignIn
import Firebase

protocol GoogleSignInBaseProtocol {
    static func setUp()
    static func handleUrl(url: URL) -> Bool
}

protocol GoogleSignInProtocol: GoogleSignInBaseProtocol {
    func config(_ controller: UIViewController?)
    func signIn()
    func signOut()
}

class GoogleSingIn: NSObject {
    
    private var currentController: UIViewController?
    
    init(controller: UIViewController? = nil) {
        print("GoogleSingIn InIt")
        super.init()
        config(controller)
    }
    
    deinit {
        print("GoogleSingIn de-InIt")
    }
}

extension GoogleSingIn: GoogleSignInProtocol {
    
    static func setUp() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    
    static func handleUrl(url: URL) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func config(_ controller: UIViewController?) {
        GIDSignIn.sharedInstance()?.presentingViewController = controller
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.delegate = self
        currentController = controller
    }
    
    func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
}

extension GoogleSingIn: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        //handle sign-in errors
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                
                Alert.presentAlert(withTitle: "Google SignIn", message: "The user has not signed in before or they have since signed out.", controller: currentController)
            } else {
                Alert.presentAlert(withTitle: "Google SignIn", message: error.localizedDescription, controller: currentController)
            }
            return
        }
        
        // Get credential object using Google ID token and Google access token
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        // Authenticate with Firebase using the credential object
        LoadingIndicator.shared.loading(step: .start(animate: true))
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if let error = error {
                print("authentication error \(error.localizedDescription)")
                Alert.presentAlert(withTitle: "Google SignIn", message: error.localizedDescription, controller: self?.currentController)
            } else {
                print(authResult?.user ?? "no user found")
                LoadingIndicator.shared.loading(step: .end)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        GIDSignIn.sharedInstance()?.disconnect()
    }
}

