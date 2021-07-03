import Foundation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

struct FacebookSignIn {
    
    private var viewController: UIViewController?
    private weak var delegate: SocialProfilesSignInDelegate?

    init(viewController: UIViewController? = nil, delegate: SocialProfilesSignInDelegate?) {
        print("FacebookSignIn InIt")
        self.viewController = viewController
        self.delegate = delegate
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
        if let _ = Auth.auth().currentUser {
            guard let token = AccessToken.current?.tokenString else {
                LoginManager().logOut()
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            self.delegate?.signInSuccess(credential: credential, signInType: .facebook)
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
        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
            if let error = error {
                self.delegate?.signInFailure(error.localizedDescription)
            } else {
                guard let token = result?.token?.tokenString else {
                  self.delegate?.signInFailure("Token nil from facebook loginManager")
                  return
                }
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                delegate?.signInSuccess(credential: credential, signInType: .facebook)
            }
        }
    }
}
