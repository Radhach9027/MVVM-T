import UIKit

class LaunchViewController: UIViewController {
    deinit {
        print("LaunchViewController de-init")
    }
}

extension LaunchViewController {
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Coordinator.route.push(story: .login, controller: .login, animated: true, modelTransistion: .crossDissolve, modelPresentation: .none).perform()
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        Coordinator.route.present(story: .login, controller: .signup, animated: true, modelTransistion: .crossDissolve, modelPresentation: .fullScreen).perform { controller in
            controller.title = "Sign Up"
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        let rootChange = UIStoryboard(name: "TabBar", bundle: nil)
        Coordinator.route.switchRootViewController(storyBoard: rootChange, controllerDestination: .tab, animated: true, window: UIWindow.key, modelTransistion: .transitionCrossDissolve).perform()
    }
}
