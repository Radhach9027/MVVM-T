import UIKit

struct AutoLogin: StorySwitchProtocol {
    
    func login() {
        
        if FirebaseSignIn.userExists {
            switchToHome()
        } else {
           switchToLaunch()
        }
    }
}
