import Foundation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

struct FacebookSignIn {
    
    private var currentController: UIViewController?
    weak var delegate: SocialSignInDelegate?

    init(controller: UIViewController? = nil) {
        print("FacebookSignIn InIt")
        currentController = controller
    }
}

extension FacebookSignIn: FacebookSignInProtocol {

    static func config(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    static func handleUrl(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func signIn() {
        if let user = Auth.auth().currentUser {
            user.getIDToken { (accessToken, error) in
                guard let token = accessToken else {
                    self.delegate?.signInFailure("Failed to retrive User accessToken")
                    return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                self.delegate?.signInSuccess(credential: credential, signInType: .facebook)
            }
        } else {
            logIn()
        }
    }
    
    static func signOut() {
        LoginManager().logOut()
    }
}

private extension FacebookSignIn {
    
    func logIn() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: currentController) { (result) in
            switch result {
                case .success(_, _, token: let token):
                    let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                    delegate?.signInSuccess(credential: credential, signInType: .facebook)
                case .cancelled:
                    self.delegate?.signInFailure("User cancelled..")
                case .failed(let error):
                    self.delegate?.signInFailure(error.localizedDescription)
            }
        }
    }
}
