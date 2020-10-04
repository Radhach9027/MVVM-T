import UIKit

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelProtocol?
    
    func config(viewModel: LoginViewModelProtocol?) {
        self.viewModel = viewModel
    }

    deinit {
     print("LoginViewController de-init")
    }
}

extension LoginViewController: LoginNavigationProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        popToRoot(to: false)
    }
}


