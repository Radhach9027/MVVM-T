import Foundation
import Firebase

//  FireBase.

protocol FirebaseProtocol {
    var userExists: Bool {get}
    var currentUser: Firebase.User? {get}
    static func signOut()
    static func signIn(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?)-> Void)
}


//  GoogleSignIn.

protocol GoogleSignInProtocol {
    func signIn()
    func setup()
    static func signOut()
    static func config()
    static func handleUrl(url: URL) -> Bool
}

// Apple

protocol AppleSignInProtocol {
    func signIn()
}

//  Facebook.

protocol FacebookSignInProtocol {
    func signIn()
    static func config(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    static func handleUrl(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

//  Twitter.

protocol TwitterLoginProtocol {
    static func config()
    func signIn()
    static func signOut()
    @discardableResult
    static func handleUrl(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

// Microsoft



// Github

//  Common Social Delegates.

protocol SocialSignInDelegate: class {
    func signInSuccess()
    func signInFailure(_ error: String)
}

