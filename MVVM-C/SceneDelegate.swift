//  Created by Radhachandan on 07/06/20.
//  Copyright © 2020 RC_Private.com. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = window, let naviagtionController = window.rootViewController as? UINavigationController else {return}
        if !SceneDelegate.isUnitTestsLaunched {
            let routing = Routing(navigation: naviagtionController, viewController: naviagtionController.topViewController, storyBoard: naviagtionController.storyboard)
            Traveller.shared.config(routing: routing)
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

extension SceneDelegate {
    static var isUnitTestsLaunched: Bool {
        if NSClassFromString("XCTest") != nil {
            return true
        }
        return false
    }
}
