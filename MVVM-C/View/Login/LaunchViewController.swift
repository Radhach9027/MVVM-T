import UIKit

class LaunchViewController: UIViewController {
    private var navigation: LaunchNavigationProtocol = LaunchNavigation()
 
    deinit {
        print("LaunchViewController de-init")
    }
}

extension LaunchViewController: StorySwitchProtocol {
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.navigation.pushToLogin(viewModel: LoginViewModel())
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.navigation.presentSignUp()
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        switchToHome()
    }
}
