import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyling()
        self.delegate = self
    }
    
    deinit {
        print("TabBarController de-init")
    }
}

extension TabBarController {
    private func setStyling() {
        UINavigationBar.customNavigation()
        UISegmentedControl.customSegmentControl()
        UITabBarItem.customTabBarItems()
        UITabBar.customTabBar()
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigation = tabBarController.selectedViewController as? UINavigationController {
            Coordinator.route.switchRouting(navigation: navigation, viewController: navigation.topViewController, storyBoard: tabBarController.storyboard).perform()
        }
    }
}
