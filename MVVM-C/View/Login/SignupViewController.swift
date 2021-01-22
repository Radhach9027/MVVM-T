import UIKit

class SignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController: LaunchScreenNavigationProtocol, StorySwitchProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        dismissController(animated: true, dismissed: {_ in})
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        pushToForgotpassword()
    }
}

extension SignupViewController: FireBaseSignInDelegate {
    
    func signInSuccess() {
        dismissController(animated: true, dismissed: { [weak self] dismissed  in
            self?.switchToHome()
        })
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}
