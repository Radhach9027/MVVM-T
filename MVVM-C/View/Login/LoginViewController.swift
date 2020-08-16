import UIKit

class LoginViewController: UIViewController {
    var viewModel = LoginViewModel()
    
    deinit {
     print("LoginViewController de-init")
    }
}

extension LoginViewController {
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        viewModel.loginUser { (result) in
            print(result)
        }
    }
}


