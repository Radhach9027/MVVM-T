//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

protocol CoordinatorViewControllerProtocol: class {
    var children: [UIViewController] { get }
    var presentedViewController: UIViewController? { get }
    var modalTransitionStyle: UIModalTransitionStyle {set get}
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func makeViewController<T>(for controller: ControllerDestination, storyBoardName: StoryDestination, storyBoard: CoordinatorStoryBoardProtocol?,  modelPresentationStyle: UIModalPresentationStyle?, modelTransistionStyle: UIModalTransitionStyle?) -> T? where T: UIViewController
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func performSegue(withIdentifier identifier: String, sender: Any?)
    func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController)
    func add(_ child: UIViewController)
    func remove()
}

extension UIViewController: CoordinatorViewControllerProtocol {}

