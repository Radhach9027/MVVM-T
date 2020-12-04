import UIKit

class SignupViewController: UIViewController {
    private var navigation: LaunchNavigationProtocol?
    
    func config(navigation: LaunchNavigationProtocol?) {
        self.navigation = navigation
    }
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController {
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        self.navigation?.dismissController(animated: true)
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        self.navigation?.pushToForgotpassword()
    }
}
