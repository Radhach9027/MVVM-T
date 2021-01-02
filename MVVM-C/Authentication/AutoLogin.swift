import UIKit

struct AutoLogin: StorySwitchProtocol {
    
    func login(window: UIWindow) {
        
        if FirebaseSignIn.userExists {
            switchToHome(window)
        } else {
            switchToLaunch(window)
        }
    }
}
