import UIKit

class SignupViewController: UIViewController {
    
    private var googleSignIn: GoogleSingIn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSignIn = GoogleSingIn(controller: self)
    }
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController: LaunchScreenNavigationProtocol{
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        dismissController(animated: true)
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        pushToForgotpassword()
    }
    
    @IBAction func googleSignInButtonPressed(_ sender: UIButton) {
        googleSignIn?.signIn()
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
    }
}
