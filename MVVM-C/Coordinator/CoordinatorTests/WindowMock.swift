@testable import Laso_Care
import UIKit

class WindowMock: CoordinatorWindowProtocol {
    var mockKeyAndVisible: Int = 0
    var rootViewController: UIViewController?
    
    func makeKeyAndVisible() {
     mockKeyAndVisible += 1
    }
}

