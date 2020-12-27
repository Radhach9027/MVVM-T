import UIKit

class SignupViewController: UIViewController {
    
    private var googleSignIn: GoogleSingIn?
    private var facebookSignIn: FacebookSignIn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
     print("SignupViewController de-init")
    }
}

extension SignupViewController: LaunchScreenNavigationProtocol, StorySwitchProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        dismissController(animated: true)
    }
    
    @IBAction func pushDetailButtonPressed(_ sender: UIButton) {
        pushToForgotpassword()
    }
    
    @IBAction func googleSignInButtonPressed(_ sender: UIButton) {
        googleSignIn = GoogleSingIn(controller: self)
        googleSignIn?.delegate = self
        googleSignIn?.signIn()
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        facebookSignIn = FacebookSignIn(controller: self)
        facebookSignIn?.delegate = self
        facebookSignIn?.singIn()
    }
}

extension SignupViewController: GoogleSignInDelegate, FacebookSignInDelegate {
    
    func signInSuccess() {
        dismissController(animated: true)
        switchToHome()
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}
