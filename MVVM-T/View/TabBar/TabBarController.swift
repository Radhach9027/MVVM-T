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

extension TabBarController: UITabBarControllerDelegate, TravellerProtocol {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigation = tabBarController.selectedViewController as? UINavigationController {
           config(navigation: navigation)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //return TabTransition(viewControllers: tabBarController.viewControllers)
        return TabFadeAnimation()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        barItemView.tabItemBounceAnimation()
    }
}
