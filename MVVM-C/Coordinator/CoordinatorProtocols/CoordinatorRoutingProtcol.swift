//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

// Mark: Routing Attributes
 protocol CoordinatorRoutingProtcol {
    func switchRootViewController(destination: ControllerDestination, storyBoard: CoordinatorStoryBoardProtocol , animated: Bool, window: CoordinatorWindowProtocol?, animations: UIView.AnimationOptions)
    func push<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T: UIViewController
    func present<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func performSegue<T>(to destination: ControllerDestination , storyDestination: StoryDestination, storyBoardProtocol: CoordinatorStoryBoardProtocol, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func addChild<T>(to childController: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func unwind<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, storyBoardSegue: CoordinatorStoryBoardSegueProtocol, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func removeChild()
    func pop(toRootController: Bool, animated: Bool, modelTransistionStyle: UIModalTransitionStyle)
    func popToViewController<T>(destination: AnyClass, animated: Bool, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func dismiss(modelTransistionStyle: UIModalTransitionStyle, animated: Bool)
}
