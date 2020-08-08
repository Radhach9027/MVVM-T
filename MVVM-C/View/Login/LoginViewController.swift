import UIKit

class LoginViewController: UIViewController {
    deinit {
     print("LoginViewController de-init")
    }
}

extension LoginViewController {
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        Coordinator.route.pop(toRootController: false, animated: true, modelTransistionStyle: .crossDissolve).perform()
    }
}


