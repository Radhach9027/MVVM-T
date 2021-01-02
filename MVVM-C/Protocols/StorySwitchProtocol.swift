import UIKit

protocol StorySwitchProtocol {
    func switchToHome(_ window: UIWindow?)
    func switchToLaunch(_ window: UIWindow?)
}

extension StorySwitchProtocol {
    
    func switchToHome(_ window: UIWindow? = UIWindow.window) {
        
        let wayFinding = returnWayFinding(window: window)
        let story = UIStoryboard(name: "TabBar", bundle: nil)
        Traveller.shared.config(wayFinding: wayFinding)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .tab, animated: true, window: window, modelTransistion: .transitionCrossDissolve).perform()
    }
    
    func switchToLaunch(_ window: UIWindow? = UIWindow.window) {
        
        let wayFinding = returnWayFinding(window: window)
        let story = UIStoryboard(name: "Login", bundle: nil)
        Traveller.shared.config(wayFinding: wayFinding)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .launch, animated: true, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
    
    private func returnWayFinding(window: UIWindow?) -> WayFinding {
        
        guard let window = window else {fatalError("returnWayFinding window nil")}
        
        var wayFinding: WayFinding?
        
        if let navigation = window.rootViewController as? UINavigationController {
            wayFinding = WayFinding(navigation: navigation, viewController: navigation.topViewController, storyBoard: navigation.storyboard)
        }
        
        if let tabBar = window.rootViewController as? TabBarController, let navigation = tabBar.selectedViewController as? UINavigationController, let viewController = navigation.topViewController {
            wayFinding = WayFinding(navigation: navigation, viewController: viewController, storyBoard: tabBar.storyboard)
        }
        
        guard let way = wayFinding else {fatalError("returnWayFinding wayFinding nil")}
        return way
    }
}

