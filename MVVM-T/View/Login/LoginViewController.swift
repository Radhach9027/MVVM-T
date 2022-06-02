import UIKit
import DependencyContainer

class LoginViewController: UIViewController {
    
    @Inject private var viewModel: LoginViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("LoginViewController de-init")
    }
}

extension LoginViewController {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        pop(type: .launch,
            root: false)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        UIWindow.showLoading(steps: .start(animate: true))
        
        viewModel.fetchUser(requestType: .all,
                            completion: { [weak self] result in
            UIWindow.showLoading(steps: .end)
            
            switch result {
                case .success(_):
                    self?.storySwitch(story: .tab,
                                      destination: .home,
                                      animated: true,
                                      hidesTopBar: false,
                                      hidesBottomBar: false)
                case let .error(error):
                    UIWindow.showAlert(message: error.debugDescription)
            }
        })
    }
    
    @IBAction func singInWithGoogle(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .google, delegate: self)
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .facebook, delegate: self)
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .apple, delegate: self)
    }
    
    @IBAction func twitterSignInButtonPressed(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .twitter, delegate: self)
    }
    
    @IBAction func microsoftSignInButtonPressed(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .microsoft, delegate: self)
    }
    
    @IBAction func githubSignInButtonPressed(_ sender: UIButton) {
        viewModel.socialProfileSignIn(signInType: .github, delegate: self)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func signInSuccess() {
        print("Current User = \(String(describing: FirebaseSignIn.currentUser?.displayName))")
        storySwitch(story: .tab,
                    destination: .home,
                    animated: true,
                    hidesTopBar: false,
                    hidesBottomBar: false)
    }
    
    func signInFailure(_ error: String) {
        UIWindow.showAlert(message: error)
    }
}


