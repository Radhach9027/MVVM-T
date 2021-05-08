import UIKit

struct AutoLogin: TravellerProtocol {
    
    func login() {
        
        if FirebaseSignIn.userExists {
            storySwitch(story: .tab, destination: .home, animated: true, hidesTopBar: true, hidesBottomBar: false)
        } else {
            _Dependencies.loginDependencies()
            storySwitch(story: .login, destination: .login, animated: true, hidesTopBar: false, hidesBottomBar: false)
        }
    }
    
    func logOut() -> String? {
        do {
            try FirebaseSignIn.signOut()
            storySwitch(story: .login, destination: .launch, animated: true, hidesTopBar: false, hidesBottomBar: false)
            _Dependencies.clearDependencies()
        } catch let signOutError as NSError {
            return "Error signing out from FirebaseSignIn: %@ \(signOutError)"
        }
        return nil
    }
}
