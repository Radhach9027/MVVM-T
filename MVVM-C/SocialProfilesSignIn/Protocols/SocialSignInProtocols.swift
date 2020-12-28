import Foundation
import Firebase

//  FireBase.

protocol FirebaseProtocol {
    var userExists: Bool {get}
    var currentUser: Firebase.User? {get}
    func signOut()
}

extension FirebaseProtocol {
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    var userExists: Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
}

//  GoogleSignIn.

protocol GoogleSignInProtocol {
    func signIn()
    func config()
    static func signOut()
    static func setUp()
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
    func signIn()
}

// Microsoft



// Github

//  Common Social Delegates.

protocol SocialSignInDelegate: class {
    func signInSuccess()
    func signInFailure(_ error: String)
}

