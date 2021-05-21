import UIKit

class LaunchViewController: UIViewController {
     
    deinit {
        print("LaunchViewController de-init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LaunchViewController: TravellerProtocol {
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        push(type: .login, animated: true, hidesTopBar: true, hidesBottomBar: false)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        present(type: .signup, animated: true, hidesTopBar: false, hidesBottomBar: false)
    }
}
