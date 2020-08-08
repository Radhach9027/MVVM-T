import UIKit

class SignupViewController: UIViewController {
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController {
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        Coordinator.route.dismiss(modelTransistionStyle: .crossDissolve, animated: true).perform()
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        Coordinator.route.push(story: .login, controller: .forgotPassword, animated: true, modelTransistion: .coverVertical, modelPresentation: .none).perform()
    }
}
