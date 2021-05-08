import UIKit
import DependencyContainer

class LoginViewController: UIViewController {
                
    @Inject private var viewModel: LoginViewModelProtocol

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let letters = "abracadabra"
        let letterCount = letters.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
        }
        
        print(letterCount)
        
    }
    
    deinit {
        print("LoginViewController de-init")
    }
}

extension LoginViewController: TravellerProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        pop(type: .launch, root: false)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.startLoading(show: true, animate: true, message: "Fetching...")
        self.viewModel.fetchUser(requestType: .all, completion: { [weak self] (status, error) in
            self?.startLoading(show: false, animate: false)
            
            if status == true {
                self?.storySwitch(story: .tab, destination: .home, animated: true, hidesTopBar: false, hidesBottomBar: false)
            } else {
                guard let errorMessage = error?.localizedDescription else { return }
                self?.presentAlert(errorMessage)
            }
        })
    }
    
    @IBAction func singInWithGoogle(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .google, delegate: self)
    }
    
    @IBAction func facebookSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .facebook, delegate: self)
    }
    
    @IBAction func appleSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .apple, delegate: self)
    }
    
    @IBAction func twitterSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .twitter, delegate: self)
    }
    
    @IBAction func microsoftSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .microsoft, delegate: self)
    }
    
    @IBAction func githubSignInButtonPressed(_ sender: UIButton) {
        self.viewModel.socialProfileSignIn(signInType: .github, delegate: self)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func signInSuccess() {
        print("Current User = \(String(describing: FirebaseSignIn.currentUser?.displayName))")
        self.storySwitch(story: .tab, destination: .home, animated: true, hidesTopBar: false, hidesBottomBar: false)
    }
    
    func signInFailure(_ error: String) {
        presentAlert(error)
    }
}


