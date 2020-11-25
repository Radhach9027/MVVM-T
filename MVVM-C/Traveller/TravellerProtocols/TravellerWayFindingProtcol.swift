//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

// Mark: WayFinding Attributes
 protocol TravellerWayFindingProtcol {
    func switchRootViewController<T>(destination: ControllerDestination, storyBoard: TravellerStoryBoardProtocol , animated: Bool, window: TravellerWindowProtocol?, animations: UIView.AnimationOptions,  configure: ((T) -> Void)?) -> T? where T : UIViewController
    func push<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T: UIViewController
    func present<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelPresentationStyle: UIModalPresentationStyle, modelTransistionStyle: UIModalTransitionStyle, animated: Bool, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func performSegue<T>(to destination: ControllerDestination , storyDestination: StoryDestination, storyBoardProtocol: TravellerStoryBoardProtocol, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func addChild<T>(to childController: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func unwind<T>(to destination: ControllerDestination, storyDestination: StoryDestination, modelTransistionStyle: UIModalTransitionStyle, storyBoardSegue: TravellerStoryBoardSegueProtocol, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func removeChild()
    func pop(toRootController: Bool, animated: Bool, modelTransistionStyle: UIModalTransitionStyle)
    func popToViewController<T>(destination: AnyClass, animated: Bool, modelTransistionStyle: UIModalTransitionStyle, configure: ((T) -> Void)?) -> T? where T : UIViewController
    func dismiss(modelTransistionStyle: UIModalTransitionStyle, animated: Bool)
}

