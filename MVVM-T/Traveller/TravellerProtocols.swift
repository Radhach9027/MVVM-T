import SwiftTraveller
import UIKit

protocol TravellerProtocol {
    
    func config(navigation: UINavigationController)
    
    func storySwitch(story: Stories, destination: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool)
    
    func push(type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool)
    func pop(type: Destinations?, root: Bool)
    
    func present(type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool)
    func dismiss()
    
    
    func addChild(type: Destinations)
    func removeChild()
    
    func performSegue(story: Stories, type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool)
    func unWind(story: Stories, type: Destinations)
}

//mark: Traveller Config
//Note: Especially when re-route is required for instance., like TabBar

extension TravellerProtocol {
    
    func config(navigation: UINavigationController) {
        let wayFinding = WayFinding(navigation: navigation, viewController: navigation.topViewController, storyBoard: navigation.storyboard)
        Traveller.shared.config(wayFinding: wayFinding)
    }
}

//mark: Story Switching

extension TravellerProtocol {
    
    func storySwitch(story: Stories, destination: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool) {
        let story = UIStoryboard(name: story.rawValue, bundle: nil)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .type(val: destination.rawValue), hidesTopBar: hidesTopBar, hidesBottomBar: hidesBottomBar, animated: animated, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
}

//mark: Push&Pop

extension TravellerProtocol {
    
    func push(type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool) {
        Traveller.route.push(controller: .type(val: type.rawValue), animated: animated, hidesTopBar: hidesTopBar, hidesBottomBar: hidesBottomBar, modelTransistion: .crossDissolve, modelPresentation: .automatic).perform()
    }
    
    func pop(type: Destinations?, root: Bool) {
        
        if let _type = type?.rawValue {
            Traveller.route.popToViewController(destination: .type(val: _type), animated: true, modelTransistionStyle: .crossDissolve).perform()
        } else {
            Traveller.route.pop(toRootController: root, animated: true, modelTransistionStyle: .crossDissolve).perform()
        }
    }
}

//mark: Present&Dismiss

extension TravellerProtocol {
    
    func present(type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool) {
        Traveller.route.present(controller: .type(val: type.rawValue), animated: animated, hidesTopBar: hidesTopBar, hidesBottomBar: hidesBottomBar, modelTransistion: .crossDissolve, modelPresentation: .overFullScreen).perform()
    }
    
    func dismiss() {
        Traveller.route.dismiss(modelTransistionStyle: .crossDissolve, animated: false){ _ in}.perform()
    }
}

//mark: Add Child&Remove Child

extension TravellerProtocol {
    
    func addChild(type: Destinations) {
        Traveller.route.addChild(childController: .type(val: type.rawValue), modelTransistionStyle: .crossDissolve).perform()
    }
    
    func removeChild() {
        Traveller.route.removeChild.perform()
    }
}

//mark: Perform Segue&Unwind

extension TravellerProtocol {
    
    func performSegue(story: Stories, type: Destinations, animated: Bool, hidesTopBar: Bool, hidesBottomBar: Bool) {
        let story = UIStoryboard(name: story.rawValue, bundle: nil)
        Traveller.route.performSegue(segue: .type(val: type.rawValue), stroyPorotocol: story, modelTransistion: .crossDissolve, animated: animated, hidesTopBar: hidesTopBar, hidesBottomBar: hidesBottomBar).perform()
    }
    
    func unWind(story: Stories, type: Destinations) {
        let story = UIStoryboard(name: story.rawValue, bundle: nil)
        Traveller.route.unwind(destination: .type(val: type.rawValue), modelTransistionStyle: .crossDissolve, storyBoardSegue: story as! TravellerStoryBoardSegueProtocol).perform()
    }
}
