//  Created by Radhachandan on 07/06/20.
//  Copyright © 2020 Radhachandan. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { fatalError("WindowScene is nil in SceneDelegate") }
        window = UIWindow(windowScene: winScene)
        if !SceneDelegate.isUnitTestsLaunched {
            AutoLogin().login()
        }
    }
}

func scene(_ scene: UIScene,
           openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let openURLContext = URLContexts.first{
        let url = openURLContext.url
        let options: [UIApplication.OpenURLOptionsKey : Any] = [
            UIApplication.OpenURLOptionsKey.annotation : openURLContext.options.annotation as Any,
            UIApplication.OpenURLOptionsKey.sourceApplication : openURLContext.options.sourceApplication as Any,
            UIApplication.OpenURLOptionsKey.openInPlace : openURLContext.options.openInPlace
        ]
        TwitterSignIn.handleUrl(app: UIApplication.shared, url: url, options: options)
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
