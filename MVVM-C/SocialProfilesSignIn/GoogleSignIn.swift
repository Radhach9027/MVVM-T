import GoogleSignIn

protocol GoogleSignInProtocol {
    func signIn()
    func signOut()
}

class GoogleSingIn: NSObject {
    
    init(controller: UIViewController) {
        print("GoogleSingIn InIt")
        super.init()
        GIDSignIn.sharedInstance()?.presentingViewController = controller
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    deinit {
        print("GoogleSingIn de-InIt")
    }
}

extension GoogleSingIn: GoogleSignInProtocol {
    
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
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        let userId = user.userID
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
}

