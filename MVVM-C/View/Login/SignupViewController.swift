import UIKit

class SignupViewController: UIViewController {
    
    private var googleSignIn: GoogleSingIn?
    private var facebookSignIn: FacebookSignIn?
    private var appleSignIn: AppleSignIn?
    private var twitterSignIn: TwitterSignIn?
    
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
        facebookSignIn?.signIn()
    }
    
    @IBAction func twitterSignInButtonPressed(_ sender: UIButton) {
        twitterSignIn = TwitterSignIn(controller: self)
        twitterSignIn?.delegate = self
        twitterSignIn?.signIn()
    }
    
    @IBAction func microsoftSignInButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func githubSignInButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        appleSignIn = AppleSignIn(controller: self)
        appleSignIn?.delegate = self
        appleSignIn?.signIn()
    }
}

extension SignupViewController: SocialSignInDelegate {
    
    func signInSuccess() {
        dismissController(animated: true)
        switchToHome()
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}
