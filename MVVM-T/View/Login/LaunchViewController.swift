import UIKit

class LaunchViewController: UIViewController {
     
    deinit {
        print("LaunchViewController de-init")
    }
}

extension LaunchViewController: StorySwitchProtocol, LaunchScreenNavigationProtocol {
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        pushToLogin()
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        presentSignUp()
    }
}
