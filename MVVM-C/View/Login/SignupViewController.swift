import UIKit

class SignupViewController: UIViewController {
    
    private var fireBaseSignIn: FirebaseSignIn? // When use any social profiles, move this to ur viewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        fireBaseSignIn = FirebaseSignIn(delegate: self)
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
    
    @IBAction func googleSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .google)
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .facebook)
    }
    
    @IBAction func twitterSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .twitter)
    }
    
    @IBAction func microsoftSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .microsoft)
    }
    
    @IBAction func githubSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .github)
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .apple)
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
