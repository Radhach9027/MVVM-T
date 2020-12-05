import UIKit

class SignupViewController: UIViewController {
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController: LaunchScreenNavigationProtocol {
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        dismissController(animated: true)
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        pushToForgotpassword()
    }
}
