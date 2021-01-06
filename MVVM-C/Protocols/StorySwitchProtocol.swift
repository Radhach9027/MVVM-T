import UIKit

protocol StorySwitchProtocol {
    func switchToHome()
    func switchToLaunch()
}

extension StorySwitchProtocol {
    
    func switchToHome() {
        let story = UIStoryboard(name: "TabBar", bundle: nil)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .tab, animated: true, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
    
    func switchToLaunch() {
        let story = UIStoryboard(name: "Login", bundle: nil)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .launch, animated: true, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
}
