import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModelProtocol?
    private var googleSignIn: GoogleSingIn?
    private var facebookSignIn: FacebookSignIn?
    private var appleSignIn: AppleSignIn?

    func config(viewModel: LoginViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    deinit {
        print("LoginViewController de-init")
    }
}

extension LoginViewController: StorySwitchProtocol, LaunchScreenNavigationProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        popToRoot(to: false)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.startLoading(show: true, animate: true, message: "Fetching...")
        self.viewModel?.fetchUser(requestType: .all, completion: { [weak self] (status, error) in
            self?.startLoading(show: false, animate: false)
            
            if status == true {
                self?.switchToHome()
            } else {
                guard let errorMessage = error?.localizedDescription else { return }
                self?.presentAlert(errorMessage)
            }
        })
    }
    
    @IBAction func singInWithGoogle(_ sender: UIButton) {
        googleSignIn = GoogleSingIn(controller: self)
        googleSignIn?.delegate = self
        googleSignIn?.signIn()
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        facebookSignIn = FacebookSignIn(controller: self)
        facebookSignIn?.delegate = self
        facebookSignIn?.signIn()
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        appleSignIn = AppleSignIn(controller: self)
        appleSignIn?.delegate = self
        appleSignIn?.signIn()
    }
}

extension LoginViewController: SocialSignInDelegate {
    
    func signInSuccess() {
        switchToHome()
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}


