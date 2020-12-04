import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModelProtocol?
    private var navigation: LaunchNavigationProtocol?
    
    func config(viewModel: LoginViewModelProtocol?, navigation: LaunchNavigationProtocol?) {
        self.viewModel = viewModel
        self.navigation = navigation
    }
    
    deinit {
        print("LoginViewController de-init")
    }
}

extension LoginViewController: StorySwitchProtocol {
    
    @IBAction func popBackButtonPressed(_ sender: UIButton) {
        self.navigation?.popToRoot(to: false)
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


