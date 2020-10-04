import UIKit

class LaunchViewController: UIViewController {
    deinit {
        print("LaunchViewController de-init")
    }
}

extension LaunchViewController: LoginNavigationProtocol, StorySwitchProtocol {
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        pushToLogin(viewModel: LoginViewModel())
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        presentSignUp()
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        switchToHome()
    }
}
