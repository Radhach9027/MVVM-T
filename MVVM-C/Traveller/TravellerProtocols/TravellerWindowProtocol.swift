//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

protocol TravellerWindowProtocol: class {
    var rootViewController: UIViewController? {get set}
    func makeKeyAndVisible()
}

extension UIWindow: TravellerWindowProtocol {}

