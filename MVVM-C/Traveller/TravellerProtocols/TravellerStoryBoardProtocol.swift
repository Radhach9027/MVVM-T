//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

protocol TravellerStoryBoardProtocol {
    func instantiateViewController(withIdentifier identifier: String) -> UIViewController
    func instantiateInitialViewController() -> UIViewController?
}

extension UIStoryboard: TravellerStoryBoardProtocol {}

