import UIKit

class SignupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        push(type: .forgotPassword,
             animated: true,
             hidesTopBar: false,
             hidesBottomBar: false)
    }
}

extension SignupViewController: FireBaseSignInDelegate {
    
    func signInSuccess() {
        dismiss()
        storySwitch(story: .tab,
                    destination: .home,
                    animated: true,
                    hidesTopBar: false,
                    hidesBottomBar: false)
    }
    
    func signInFailure(_ error: String) {
        print("Error")
    }
}
