import UIKit

class LoginViewController: UIViewController {
                
    @Inject private var viewModel: LoginViewModelProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel._delgate = self
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
        self.viewModel.fetchUser(requestType: .all, completion: { [weak self] (status, error) in
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
        self.viewModel.socialProfileSignIn(signInType: .google)
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .facebook)
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .apple)
    }
    
    @IBAction func twitterSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .twitter)
    }
    
    @IBAction func microsoftSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .microsoft)
    }
    
    @IBAction func githubSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .github)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func signInSuccess() {
        print("Current User = \(String(describing: FirebaseSignIn.currentUser?.displayName))")
        switchToHome()
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}


