import Foundation
import Firebase
import UIKit

//  FireBase.
protocol FirebaseProtocol {
    static var userExists: Bool {get}
    static var currentUser: Firebase.User? {get}
    static func signOut() throws
    func signIn(signInType: SocialSignInType,
                delgate: FireBaseSignInDelegate)
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
    static func signOut()
    static func config(application: UIApplication,
                       launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    static func handleUrl(app: UIApplication,
                          url: URL,
                          options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

//  Twitter.
protocol TwitterSignInProtocol {
    static func config()
    func signIn()
    static func signOut()
    @discardableResult
    static func handleUrl(app: UIApplication,
                          url: URL,
                          options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

