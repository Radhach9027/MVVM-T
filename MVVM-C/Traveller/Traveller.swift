//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

/**
 !* @discussion: This class controls all the navigation behaviour for the entire Application. It has been using as Singleton object via shared reference.
 */

class Traveller {
    private static var sharedInstance: Traveller?
    private var wayFinding: TravellerWayFindingProtocol?
    var storage: [Any] = [] // To store current stack when config is about to change the router.
    
    class var shared : Traveller {
        guard let sharedInstance = self.sharedInstance else {
            let sharedInstance = Traveller()
            self.sharedInstance = sharedInstance
            return sharedInstance
        }
        return sharedInstance
    }
    
    private init() {
        print("Traveller init")
    }
    
    /**
     !* @discussion: Configuration part for entire Navigation WayFinding.
     !* @param: TravellerWayFindingProtocol ---> This controls entire WayFinding of the app with the help of WayFinding class which conforms to TravellerWayFindingProtocol & internally this has control over UINavigationController, UIViewController, UIStoryboard, UIStoryboardSegue, UIWindow. Please refere inside logic for more understanding.
     */
    func config(wayFinding: TravellerWayFindingProtocol?) {
        guard let _wayFinding = wayFinding else { fatalError("Traveller config failed to assign router") }
        self.wayFinding = _wayFinding
    }
    
    /**
     !* @discussion: This will remove Traveller reference from the memory
     */
    func clear() {
        self.wayFinding = nil
        Traveller.sharedInstance = nil
    }
    
    deinit {
        print("Traveller de-init")
    }
}

extension Traveller {
    enum route: Equatable {
        
        /**
         !* @discussion: All the below cases refers to navigation attributes, let's go one by one.
         !* @param: StoryDestination ---> This refers to StoryBoard file name
         !* @param: ControllerDestination ---> This refers to Controller file name
         !* @param: TravellerWindowProtocol ---> This refers to UIWindow that conforms to custom protocol, this protcol will be helpful to mock the object.
         !* @param: UIModalPresentationStyle ---> ViewController presentation style.
         !* @param: UIModalTransitionStyle ---> ViewController presentation animations.
         !* @param: Bool ---> Manipluates required logic, Please refer to inner logic.
         !* @param: TravellerNavigationProtocol ----> Takes cares of naviagtion
         !* @param: TravellerViewControllerProtocol ----->  Takes cares of viewcontroller
         !* @param: TravellerStoryBoardProtocol  ----->  Takes cares of storyBoard
         !* @return: UIViewController --->  Returns respective UIViewController at required places, once the logic has been rendered.
         */
        
        /**
         !* @discussion:  This function will help to change the window rootViewController.
         */
        case switchRootViewController(storyBoard: TravellerStoryBoardProtocol, controllerDestination: ControllerDestination, animated: Bool, window: TravellerWindowProtocol?, modelTransistion: UIView.AnimationOptions)
        
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
        case performSegue(segue: ControllerDestination, story: StoryDestination, stroyPorotocol: TravellerStoryBoardProtocol, modelTransistion: UIModalTransitionStyle)
        
        
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
        case unwind(destination: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, storyBoardSegue: TravellerStoryBoardSegueProtocol)
        
        /**
         !* @discussion:  This function will help to dismiss the presented ViewController on current ViewController.
         */
        case dismiss(modelTransistionStyle: UIModalTransitionStyle, animated: Bool)
        

        @discardableResult
        func perform<T>(_ configure: ((T) -> Void)? = nil) -> T? where T: UIViewController {
            switch self {
            case let .switchRootViewController(storyBoard, destination, animated, window, modelTransistion):
                return Traveller.shared.wayFinding?.switchRootViewController(destination: destination, storyBoard: storyBoard, animated: animated, window: window, animations: modelTransistion, configure: configure)
            case let .present(story, controller, animated, modelTransistion, modelPresentation):
                return Traveller.shared.wayFinding?.present(to: controller, storyDestination: story, modelPresentationStyle: modelPresentation, modelTransistionStyle: modelTransistion, animated: animated, configure: configure)
            case let .push(story, controller, animated, modelTransistion, modelPresentation):
                return Traveller.shared.wayFinding?.push(to: controller, storyDestination: story, modelPresentationStyle: modelPresentation, modelTransistionStyle: modelTransistion, animated: animated, configure: configure)
            case let .performSegue(segue, story, stroyPorotocol, modelTransistion):
                return Traveller.shared.wayFinding?.performSegue(to: segue, storyDestination: story, storyBoardProtocol: stroyPorotocol, modelTransistionStyle: modelTransistion, configure: configure)
            case let .addChild(childController, storyDestination, modelTransistionStyle):
                return Traveller.shared.wayFinding?.addChild(to: childController, storyDestination: storyDestination, modelTransistionStyle: modelTransistionStyle, configure: configure)
            case .removeChild:
                Traveller.shared.wayFinding?.removeChild()
            case let .pop(toRootController, animated, modelTransistionStyle):
                Traveller.shared.wayFinding?.pop(toRootController: toRootController, animated: animated, modelTransistionStyle: modelTransistionStyle)
            case let .popToViewController(destination, animated, modelTransistionStyle):
                return Traveller.shared.wayFinding?.popToViewController(destination: destination, animated: animated, modelTransistionStyle: modelTransistionStyle, configure: configure)
            case let .dismiss(modelTransistionStyle, animated):
                Traveller.shared.wayFinding?.dismiss(modelTransistionStyle: modelTransistionStyle, animated: animated)
            case let .unwind(destination, storyDestination, modelTransistionStyle, storyBoardSegue):
                return Traveller.shared.wayFinding?.unwind(to: destination, storyDestination: storyDestination, modelTransistionStyle: modelTransistionStyle, storyBoardSegue: storyBoardSegue, configure: configure)
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


