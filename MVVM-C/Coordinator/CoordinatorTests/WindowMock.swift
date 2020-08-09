@testable import MVVM_C
import UIKit

class WindowMock: CoordinatorWindowProtocol {
    var mockKeyAndVisible: Int = 0
    var rootViewController: UIViewController?
    
    func makeKeyAndVisible() {
     mockKeyAndVisible += 1
    }
}

