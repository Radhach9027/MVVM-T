@testable import MVVM_T
import UIKit

class NavigationControllerMock: TravellerNavigationProtocol {    

    var topViewController: UIViewController? {
        get {
            return self.navigationController?.topViewController
        }
    }
    
    var visibleViewController: UIViewController? {
        get {
            return self.navigationController?.visibleViewController
        }
    }
    
    var viewControllers: [UIViewController] {
        get {
            return self.navigationController?.viewControllers ?? []
        }
        set {
            self.navigationController?.viewControllers = newValue
        }
    }
    
    var navigationController: UINavigationController?
    
    var mockPushViewController: UIViewController?
    var mockPopToViewController: UIViewController?
    var mockPopViewControllerTriggered: Int = 0
    var mockPopToRootViewControllerTriggered: Int = 0
    
    
    init(navigation: UINavigationController?) {
        self.navigationController = navigation
        print("NavigationControllerMock init")
    }
    
    
    func popViewController(animated: Bool) -> UIViewController? {
        mockPopViewControllerTriggered += 1
        return nil
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let popToViewController = self.viewControllers.first(where: {$0.accessibilityLabel == viewController.accessibilityLabel}) else { return nil }
        mockPopToViewController = popToViewController
        return nil
    }
    
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        mockPopToRootViewControllerTriggered += 1
        return nil
    }
    
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        self.navigationController?.viewControllers = viewControllers
    }
    
    func makeRootNavigation(to rootViewController: UIViewController?, isNavigationHidden: Bool) -> UINavigationController? {
        guard let rootVc = rootViewController else { return nil }
        let navController = UINavigationController(rootViewController: rootVc)
        navController.setNavigationBarHidden(isNavigationHidden, animated: false)
        return navController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        mockPushViewController = viewController
    }
}

