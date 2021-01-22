@testable import MVVM_T
import UIKit

class WindowMock: TravellerWindowProtocol {
    var mockKeyAndVisible: Int = 0
    var rootViewController: UIViewController?
    
    func makeKeyAndVisible() {
     mockKeyAndVisible += 1
    }
}

