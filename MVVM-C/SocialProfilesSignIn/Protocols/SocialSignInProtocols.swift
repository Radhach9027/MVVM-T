import Foundation
import Firebase

//  FireBase.

protocol FirebaseProtocol {
    static func signOut()
    func signIn()
}

extension FirebaseProtocol {
    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

//  GoogleSignIn.

protocol GoogleSignInProtocol: FirebaseProtocol {
    func config()
    static func setUp()
    static func handleUrl(url: URL) -> Bool
}

// Apple

protocol AppleSignInProtocol: FirebaseProtocol {}

//  Facebook.

protocol FacebookSignInProtocol: FirebaseProtocol {
    static func config(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    static func handleUrl(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

//  Twitter.

protocol TwitterLoginProtocol: FirebaseProtocol {}

// Microsoft



// Github

//  Common Social Delegates.

protocol SocialSignInDelegate: class {
    func signInSuccess()
    func signInFailure(_ error: String)
}

