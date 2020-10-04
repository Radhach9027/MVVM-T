//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

final class Routing: NSObject, UIAdaptivePresentationControllerDelegate {
    private var navigation: CoordinatorNavigationProtocol?
    private var viewController : CoordinatorViewControllerProtocol?
    private var storyBoard: CoordinatorStoryBoardProtocol?

    init(navigation: CoordinatorNavigationProtocol?, viewController : CoordinatorViewControllerProtocol?, storyBoard: CoordinatorStoryBoardProtocol?) {
        self.navigation = navigation
        self.storyBoard = storyBoard
        self.viewController = viewController
        print("Routing init")
    }
    
    deinit {
        print("Routing deinit")
    }
}

extension Routing: CoordinatorRoutingProtcol {
    
    /**
     !* @discussion: This function takes cares of switching root viewcontroller from one to other.
     !* @param: ControllerDestination, storyBoard , animated, window, animations
     1. Intially we are loading controller from stroyboard by using  storyBoard.instantiateViewController via CoordinatorStoryBoardProtocol.
     2. Once fetching the controller from storyboard, we are getting the window object by CoordinatorWindowProtocol.
     3. Then applying animation using animations via UIView.AnimationOptions, finally setting the rootView to window object.
     4. Finally apply new routing config to old routing config.
     Note: Check if you'r using tabbar controller or general navigation.
     */
    
    func switchRootViewController<T>(destination: ControllerDestination, storyBoard: CoordinatorStoryBoardProtocol , animated: Bool, window: CoordinatorWindowProtocol?, animations: UIView.AnimationOptions,  configure: ((T) -> Void)?) -> T? where T : UIViewController {
        let storyBoard = storyBoard.instantiateInitialViewController()
        if animated {
            guard let window = window else { return nil }
            UIView.transition(with: window as! UIView, duration: 0.5, options: animations, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = storyBoard
                UIView.setAnimationsEnabled(oldState)
            }, completion: nil)
        }else {
            window?.rootViewController = storyBoard
        }
        window?.makeKeyAndVisible()
        
        var routing: Routing?
        if let tabBarController = window?.rootViewController as? UITabBarController, let navigationController = tabBarController.selectedViewController as? UINavigationController {
            routing = Routing(navigation: navigationController, viewController: navigationController.topViewController, storyBoard: window?.rootViewController?.storyboard)
        } else {
            guard let navigation = window?.rootViewController as? UINavigationController, let viewController = navigation.topViewController, let storyBoard = navigation.storyboard else { return nil }
            routing = Routing(navigation: navigation, viewController: viewController, storyBoard: storyBoard)
        }
        
        Coordinator.shared.config(routing: routing)
        configure?(routing?.navigation?.topViewController as! T)
        return routing?.navigation?.topViewController as? T
    }

    
    /**
     !* @discussion: This function takes cares of pushing viewcontroller over navigation controller.
     !* @param: ControllerDestination, storyDestination , modelPresentationStyle, modelTransistionStyle
     1. We are trying to prepare a view controller with the help of ControllerDestination & storyDestination and then adding presenting style, transistion style by using modelPresentationStyle & modelTransistionStyle to self.viewController?.makeViewController via CoordinatorViewControllerProtocol.
     2. Then assigning the current root navigation,viewcontroller, storyboard  to main navigation,viewcontroller, storyboard in order to maintain the stack. (This will help us to push on presented view controller)
     3. Then we are fetching navigation via CoordinatorNavigationProtocol and finally pushing & returning the controller.
     */
    
    func push<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T: UIViewController {
        if let viewController = self.viewController?.makeViewController(for: destination, storyBoardName: storyDestination, storyBoard: self.storyBoard , modelPresentationStyle: modelPresentationStyle, modelTransistionStyle: modelTransistionStyle) as? T, let navigation = self.navigation {
            configure?(viewController)
            navigation.pushViewController(viewController, animated: animated)
            return viewController
        }
        return nil
    }
    
    /**
     !* @discussion: This function takes cares of presenting viewcontroller on navigation controller as a root navigation.
     !* @param: ControllerDestination, storyDestination , modelPresentationStyle, modelTransistionStyle
     1. We are trying to prepare a view controller with the help of ControllerDestination & storyDestination and then adding presenting style, transistion style by using modelPresentationStyle & modelTransistionStyle to self.viewController?.makeViewController via CoordinatorViewControllerProtocol.
     2. Then we are fetching root navigation by self.navigation?.makeRootNavigation via CoordinatorNavigationProtocol and passing current controller as root to it.
     3. Then assigning the current root navigation,viewcontroller, storyboard  to main navigation,viewcontroller, storyboard in order to maintain the stack. (This will help us to push on presented view controller)
     4. Finally we are presenting the controller & returning it.
     */
    
    func present<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T : UIViewController {
        if let viewController = self.viewController?.makeViewController(for: destination, storyBoardName: storyDestination, storyBoard: self.storyBoard, modelPresentationStyle: modelPresentationStyle, modelTransistionStyle: modelTransistionStyle) as? T, let navigation = self.navigation?.makeRootNavigation(to: viewController, isNavigationHidden: false), let topViewController = self.viewController {
            configure?(viewController)
            self.stackStorage()
            let routing = Routing(navigation: navigation, viewController: viewController, storyBoard: self.storyBoard)
            Coordinator.shared.config(routing: routing)
            topViewController.present(navigation, animated: animated, completion: nil)
            navigation.presentationController?.delegate = self
            return viewController
        }
        return nil
    }
    
    
    /**
     !* @discussion: This function takes cares of routingConfi when ever it's required.
     !* @param: navigation, viewController , storyBoard
     1. When ever if there is a change in the navigation stack, we have to use this function. In-order to main the stack.
      
     Note: If you'r using tabbar controller in your application, call this function in you'r TabBarController delegate method didSelect. In-order to manage navigation stack in tabbar controller.
     */
    
    func performSegue<T>(to destination: ControllerDestination , storyDestination: StoryDestination, storyBoardProtocol: CoordinatorStoryBoardProtocol, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController {
        if let viewController = self.viewController?.makeViewController(for: destination, storyBoardName: storyDestination, storyBoard: storyBoardProtocol, modelPresentationStyle: nil, modelTransistionStyle: modelTransistionStyle) as? T, let topViewController: CoordinatorViewControllerProtocol = self.viewController {
            configure?(viewController)
            topViewController.performSegue(withIdentifier: destination.rawValue, sender: viewController)
            return viewController
        }
        return nil
    }
    
    
    /**
     !* @discussion: This function takes cares of adding child viewcontroller on current controller.
     !* @param: ControllerDestination, storyDestination , modelTransistionStyle
     1. We are trying to prepare a view controller with the help of ControllerDestination & storyDestination and then adding transistion style by using modelTransistionStyle to self.viewController?.makeViewController via CoordinatorViewControllerProtocol.
     2. Then we are fetching current controller which is visible on the screen by using self.viewController via CoordinatorViewControllerProtocol.
     3. Then assigning the current root navigation,viewcontroller, storyboard  to main navigation,viewcontroller, storyboard in order to maintain the stack. (This will help us to push on presented view controller)
     4. Finally we are adding the controller as child & returning it.
     Note: If you dont want present something from child, then avoid point 3. That will remain same.
     */
    
    func addChild<T>(to childController: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController {
        if let viewController = self.viewController?.makeViewController(for: childController, storyBoardName: storyDestination, storyBoard: self.storyBoard , modelPresentationStyle: nil, modelTransistionStyle: modelTransistionStyle) as? T, let topController = self.viewController {
            configure?(viewController)
            let routing = Routing(navigation: self.navigation, viewController: viewController, storyBoard: self.storyBoard)
            Coordinator.shared.config(routing: routing)
            topController.add(viewController)
            return viewController
        }
        return nil
    }
    
    
    /**
     !* @discussion: This function takes cares of routingConfi when ever it's required.
     !* @param: navigation, viewController , storyBoard
     1. When ever if there is a change in the navigation stack, we have to use this function. In-order to main the stack.
      
     Note: If you'r using tabbar controller in your application, call this function in you'r TabBarController delegate method didSelect. In-order to manage navigation stack in tabbar controller.
     */
    
    func unwind<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, storyBoardSegue: CoordinatorStoryBoardSegueProtocol, configure: ((T) -> Void)?) -> T? where T : UIViewController {
        if let topViewController = self.viewController as? T , let destinationVc = self.viewController?.makeViewController(for: destination, storyBoardName: storyDestination, storyBoard: self.storyBoard, modelPresentationStyle: nil, modelTransistionStyle: modelTransistionStyle) as? T{
            configure?(topViewController)
            topViewController.unwind(for: UIStoryboardSegue(identifier: storyBoardSegue.identifier, source: storyBoardSegue.source, destination: storyBoardSegue.destination), towards: destinationVc)
            return topViewController
        }
        return nil
    }
    
    
    /**
     !* @discussion: This function takes cares of removing child controller on top controller.
     */
    
    func removeChild() {
        if let childViewController = self.viewController {
            childViewController.remove()
        }
    }
    
    
    /**
     !* @discussion: This function takes cares of popping controller to root or previous.
     !* @param: toRootController, animated, modelTransistionStyle
     1. Based on the flags toRootController, animated, modelTransistionStyle it gonna act accordinly to navigation.
     */
    
    func pop(toRootController: Bool, animated: Bool, modelTransistionStyle: UIModalTransitionStyle) {
        if let navigationController = self.navigation {
            if toRootController {
                if (self.viewController?.presentedViewController != nil) {
                  dismiss(modelTransistionStyle: modelTransistionStyle, animated: animated)
                } else {
                    navigationController.popToRootViewController(animated: animated)
                }
            } else {
                navigationController.popViewController(animated: animated)
            }
        }
    }
    
    
    /**
     !* @discussion: This function takes cares of popping to respective viewcontroller with-in navigation stack.
     !* @param: destination, animated, modelTransistionStyle
     1. A destination view controller should be passed and can apply modelTransistionStyle & animated flags to it.
     2. This will check the child controllers of navigation and if destination exists in that, then this will pop to destination,
     */
    
    func popToViewController<T>(destination: AnyClass, animated: Bool, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController {
        if let navigationController = self.navigation {
            for controller in navigationController.viewControllers where controller.isKind(of: destination) {
                if let controller = controller as? T {
                    configure?(controller)
                    navigationController.popToViewController(controller, animated: animated)
                    return controller
                }
            }
        }
        return nil
    }
    
    /**
     !* @discussion: This function takes cares of dismissing the presented controller on stack.
     !* @param: modelTransistionStyle, animated
     1. Apply modelTransistionStyle and animated flag accordingly.
     */
    
    func dismiss(modelTransistionStyle: UIModalTransitionStyle, animated: Bool) {
        if let topViewController = self.viewController{
            topViewController.modalTransitionStyle = modelTransistionStyle
            topViewController.dismiss(animated: animated) { [weak self] in
                self?.checkStorageAndReassignRoutingWhenControllerIsDismissed()
            }
        }
    }
}

extension Routing {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.checkStorageAndReassignRoutingWhenControllerIsDismissed()
    }
}

private extension Routing {
    func stackStorage() {
        guard let navigation = self.navigation, let controller = self.viewController, let storyBoard = self.storyBoard else { return }
        Coordinator.shared.storage.removeAll()
        Coordinator.shared.storage.append(storyBoard)
        Coordinator.shared.storage.append(navigation)
        Coordinator.shared.storage.append(controller)
    }
    
    func checkStorageAndReassignRoutingWhenControllerIsDismissed() {
        if Coordinator.shared.storage.count > 0{
            self.storyBoard = Coordinator.shared.storage[0] as? CoordinatorStoryBoardProtocol
            self.navigation = Coordinator.shared.storage[1] as? CoordinatorNavigationProtocol
            self.viewController = Coordinator.shared.storage[2] as? CoordinatorViewControllerProtocol
        }
    }
}


