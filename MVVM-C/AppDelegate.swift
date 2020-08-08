//  Created by Radhachandan on 07/06/20.
//  Copyright © 2020 RC_Private.com. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if UIDevice().isJailBroken {
            exit(0)
        } else {
            NetworkReachability.shared.startNotifier()
            reachabilityObserver()
            return true
        }
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate {
    func reachabilityObserver() {
        NetworkReachability.shared.reachabilityObserver = { status in
            switch status {
            case .connected:
                _ = AnimatedView(message: .internet, postion: .top, bgColor: UIColor().appColor())
            case .disconnected:
                _ = AnimatedView(message: .noInternet, postion: .top, bgColor: .orange)
            }
        }
    }
}


