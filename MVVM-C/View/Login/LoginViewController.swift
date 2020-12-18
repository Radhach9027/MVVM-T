import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModelProtocol?
    
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
}


