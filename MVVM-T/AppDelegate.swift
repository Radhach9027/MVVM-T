//  Created by Radhachandan on 07/06/20.
//  Copyright © 2020 Radhachandan. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UIDevice().isJailBroken {
            exit(0)
        } else {
            GoogleSingIn.config()
            FacebookSignIn.config(application: application,
                                  launchOptions: launchOptions)
            TwitterSignIn.config()
            return true
        }
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate {

    @available(iOS 9.0, *)
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let googleUrl = GoogleSingIn.handleUrl(url: url)
        let facebookUrl = FacebookSignIn.handleUrl(app: app,
                                                   url: url,
                                                   options: options)
        let twitterUrl = TwitterSignIn.handleUrl(app: app,
                                                 url: url,
                                                 options: options)
        
        return googleUrl || facebookUrl || twitterUrl
    }
}


