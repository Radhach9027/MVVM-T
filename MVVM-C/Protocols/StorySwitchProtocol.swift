import UIKit

protocol StorySwitchProtocol {
    func switchToHome()
    func switchToLogin()
}

extension StorySwitchProtocol {
    
    func switchToHome() {
        let story = UIStoryboard(name: "TabBar", bundle: nil)
        Coordinator.route.switchRootViewController(storyBoard: story, controllerDestination: .tab, animated: false, window: UIWindow.key, modelTransistion: .transitionCrossDissolve).perform()
    }
    
    func switchToLogin() {
        let story = UIStoryboard(name: "Login", bundle: nil)
         Coordinator.route.switchRootViewController(storyBoard: story, controllerDestination: .login, animated: false, window: UIWindow.key, modelTransistion: .transitionCrossDissolve).perform()
    }
}

