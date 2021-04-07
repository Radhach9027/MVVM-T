import UIKit

struct AutoLogin: TravellerProtocol, DependencyProtocol {
    
    func login() {
        
        if FirebaseSignIn.userExists {
            storySwitch(story: .tab, destination: .home, animated: true, hidesTopBar: true, hidesBottomBar: false)
        } else {
            loginDependencies()
            storySwitch(story: .login, destination: .login, animated: true, hidesTopBar: false, hidesBottomBar: false)
        }
    }
}
