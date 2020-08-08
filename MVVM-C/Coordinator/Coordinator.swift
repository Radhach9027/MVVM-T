//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

/**
 !* @discussion: This class controls all the navigation behaviour for the entire Application. It has been using as Singleton object via shared reference.
 */

class Coordinator {
    private static var sharedInstance: Coordinator?
    private var routing: CoordinatorRoutingProtcol?
    
    class var shared : Coordinator {
        guard let sharedInstance = self.sharedInstance else {
            let sharedInstance = Coordinator()
            self.sharedInstance = sharedInstance
            return sharedInstance
        }
        return sharedInstance
    }
    
    private init() {
        print("Coordinator init")
    }
    
    /**
     !* @discussion: Configuration part for entire Navigation Routing.
     !* @param: CoordinatorRoutingProtcol ---> This controls entire routing of the app with the help of Routing class which conforms to CoordinatorRoutingProtcol & internally this has control over UINavigationController, UIViewController, UIStoryboard, UIStoryboardSegue, UIWindow. Please refere inside logic for more understanding.
     */
    func config(routing: CoordinatorRoutingProtcol?) {
        guard let routing = routing else { fatalError("Coordinator config failed to assign router") }
        self.routing = routing
    }
    
    /**
     !* @discussion: This will remove Coordinator reference from the memory
     */
    func clear() {
        self.routing = nil
        Coordinator.sharedInstance = nil
    }
    
    deinit {
        print("Coordinator de-init")
    }
}

extension Coordinator {
    enum route: Equatable {
        
        /**
         !* @discussion: All the below cases refers to navigation attributes, let's go one by one.
         !* @param: StoryDestination ---> This refers to StoryBoard file name
         !* @param: ControllerDestination ---> This refers to Controller file name
         !* @param: CoordinatorWindowProtocol ---> This refers to UIWindow that conforms to custom protocol, this protcol will be helpful to mock the object.
         !* @param: UIModalPresentationStyle ---> ViewController presentation style.
         !* @param: UIModalTransitionStyle ---> ViewController presentation animations.
         !* @param: Bool ---> Manipluates required logic, Please refer to inner logic.
         !* @param: CoordinatorNavigationProtocol ----> Takes cares of naviagtion
         !* @param: CoordinatorViewControllerProtocol ----->  Takes cares of viewcontroller
         !* @param: CoordinatorStoryBoardProtocol  ----->  Takes cares of storyBoard
         !* @return: UIViewController --->  Returns respective UIViewController at required places, once the logic has been rendered.
         */
        
        /**
         !* @discussion:  This function will help to change the window rootViewController.
         */
        case switchRootViewController(storyBoard: CoordinatorStoryBoardProtocol, controllerDestination: ControllerDestination, animated: Bool, window: CoordinatorWindowProtocol?, modelTransistion: UIView.AnimationOptions)
        
        /**
         !* @discussion:  This function will help to present the ViewController from curren ViewController as a root navigation.
         */
        case present(story: StoryDestination, controller: ControllerDestination, animated: Bool, modelTransistion: UIModalTransitionStyle, modelPresentation: UIModalPresentationStyle)
        
        /**
         !* @discussion:  This function will help to push the ViewController from curren ViewController navigation.
         */
        case push(story: StoryDestination, controller: ControllerDestination, animated: Bool, modelTransistion: UIModalTransitionStyle, modelPresentation: UIModalPresentationStyle)
        
        /**
         !* @discussion:  This function will help to performSegue to respective  ViewController using UIStoryBoardSegue.
         !* @note:  In-Order to use this we need to wire segues in StoryBoard.
         */
        case performSegue(segue: ControllerDestination, story: StoryDestination, stroyPorotocol: CoordinatorStoryBoardProtocol, modelTransistion: UIModalTransitionStyle)
        
        
        /**
         !* @discussion:  This function will help to adds the respective controller as a child on current  ViewController and returns back  child ViewController.
         */
        case addChild(childController: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle)
        
        /**
         !* @discussion:  This function will help to remove the child controller on current controller.
         */
        case removeChild
        
        
        /**
         !* @discussion:  This function will help to pop the current controller from navigation stack. We can use pop to root or previous controller based on Bool value.
         */
        case pop(toRootController: Bool, animated: Bool, modelTransistionStyle: UIModalTransitionStyle)
        
        
        /**
         !* @discussion:  This function will help to pop the respective view controller from navigation stack, and return back the popped view controller.
         */
        case popToViewController(destination: AnyClass, animated: Bool, modelTransistionStyle: UIModalTransitionStyle)
        
        
        /**
         !* @discussion:  This function will help to go back  to respective  ViewController using UIStoryBoardSegue with unwind.
         !* @note:  In-Order to use this we need to wire segues in StoryBoard.
         */
        case unwind(destination: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, storyBoardSegue: CoordinatorStoryBoardSegueProtocol)
        
        /**
         !* @discussion:  This function will help to dismiss the presented ViewController on current ViewController.
         */
        case dismiss(modelTransistionStyle: UIModalTransitionStyle, animated: Bool)
        

        /**
          !* @discussion:  This function will help to switch routing.
          */
        case switchRouting(navigation: CoordinatorNavigationProtocol?, viewController: CoordinatorViewControllerProtocol?, storyBoard: CoordinatorStoryBoardProtocol?)
        
        @discardableResult
        func perform<T>(_ configure: ((T) -> Void)? = nil) -> T? where T: UIViewController {
            switch self {
            case let .switchRootViewController(storyBoard, destination, animated, window, modelTransistion):
                Coordinator.shared.routing?.switchRootViewController(destination: destination, storyBoard: storyBoard, animated: animated, window: window, animations: modelTransistion)
            case let .present(story, controller, animated, modelTransistion, modelPresentation):
                return Coordinator.shared.routing?.present(to: controller, storyDestination: story, modelPresentationStyle: modelPresentation, modelTransistionStyle: modelTransistion, animated: animated, configure: configure)
            case let .push(story, controller, animated, modelTransistion, modelPresentation):
                return Coordinator.shared.routing?.push(to: controller, storyDestination: story, modelPresentationStyle: modelPresentation, modelTransistionStyle: modelTransistion, animated: animated, configure: configure)
            case let .performSegue(segue, story, stroyPorotocol, modelTransistion):
                return Coordinator.shared.routing?.performSegue(to: segue, storyDestination: story, storyBoardProtocol: stroyPorotocol, modelTransistionStyle: modelTransistion, configure: configure)
            case let .addChild(childController, storyDestination, modelTransistionStyle):
                return Coordinator.shared.routing?.addChild(to: childController, storyDestination: storyDestination, modelTransistionStyle: modelTransistionStyle, configure: configure)
            case .removeChild:
                Coordinator.shared.routing?.removeChild()
            case let .pop(toRootController, animated, modelTransistionStyle):
                Coordinator.shared.routing?.pop(toRootController: toRootController, animated: animated, modelTransistionStyle: modelTransistionStyle)
            case let .popToViewController(destination, animated, modelTransistionStyle):
                return Coordinator.shared.routing?.popToViewController(destination: destination, animated: animated, modelTransistionStyle: modelTransistionStyle, configure: configure)
            case let .dismiss(modelTransistionStyle, animated):
                Coordinator.shared.routing?.dismiss(modelTransistionStyle: modelTransistionStyle, animated: animated)
            case let .unwind(destination, storyDestination, modelTransistionStyle, storyBoardSegue):
                return Coordinator.shared.routing?.unwind(to: destination, storyDestination: storyDestination, modelTransistionStyle: modelTransistionStyle, storyBoardSegue: storyBoardSegue, configure: configure)
            case let .switchRouting(navigation, viewController, storyBoard):
                Coordinator.shared.routing?.switchRouting(navigation: navigation, viewController: viewController, storyBoard: storyBoard)
            }
            return nil
        }
        
        
        static func ==(lhs: route, rhs: route) -> Bool {
            switch (lhs, rhs) {
            case let (.pop(lhstoRoot, lhsanimate, lhsTransistionStyle), .pop(rhstoRoot, rhsanimate, rhsTransistionStyle)):
                return lhstoRoot == rhstoRoot && rhsanimate == lhsanimate && lhsTransistionStyle == rhsTransistionStyle
            default:
                break
            }
            return false
        }
    }
}
