//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

protocol CoordinatorStoryBoardSegueProtocol: class {
    var identifier: String? { get }
    var source: UIViewController { get }
    var destination: UIViewController { get }
}

extension UIStoryboardSegue: CoordinatorStoryBoardSegueProtocol {}
