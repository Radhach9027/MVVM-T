@testable import Laso_Care
import UIKit

class ViewControllerMock: CoordinatorViewControllerProtocol {
    var presentedViewController: UIViewController?
    var mockPresentedViewController: UIViewController?
    var mockViewController: UIViewController?
    var mockDismissTriggered: Int = 0
    var mockRemoveChildTriggered: Int = 0
    var children: [UIViewController] = []
    var modalTransitionStyle: UIModalTransitionStyle = .coverVertical
    var mockSegueIdentifier: String?

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        if let viewController = viewControllerToPresent.children.first {
            mockPresentedViewController = viewController
        }
    }
    
    func makeViewController<T>(for controller: ControllerDestination, storyBoardName: StoryDestination, storyBoard: CoordinatorStoryBoardProtocol?, modelPresentationStyle: UIModalPresentationStyle?, modelTransistionStyle: UIModalTransitionStyle?) -> T? where T : UIViewController {
        mockViewController = UIViewController(nibName: controller.rawValue, bundle: nil)
        if let presentation = modelPresentationStyle {
            mockViewController?.modalPresentationStyle = presentation
        }
        if let transistion = modelTransistionStyle {
            mockViewController?.modalTransitionStyle = transistion
        }
        return mockViewController as? T
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        mockDismissTriggered += 1
    }
    
    func performSegue(withIdentifier identifier: String, sender: Any?) {
        mockSegueIdentifier = identifier
    }
    
    func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }
    
    func add(_ child: UIViewController) {
        self.children.append(child)
    }
    
    func remove() {
        mockRemoveChildTriggered += 1
    }
}

