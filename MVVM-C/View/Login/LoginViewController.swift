import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModelProtocol?
    private var fireBaseSignIn: FirebaseSignIn?

    func config(viewModel: LoginViewModelProtocol?) {
        self.viewModel = viewModel
        fireBaseSignIn = FirebaseSignIn(viewController: self)
        fireBaseSignIn?.delegate = self
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
        fireBaseSignIn?.signIn(signInType: .google)
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .facebook)
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        fireBaseSignIn?.signIn(signInType: .apple)
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
}

extension LoginViewController: FireBaseSignInDelegate {
    
    func signInSuccess() {
        switchToHome()
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}


