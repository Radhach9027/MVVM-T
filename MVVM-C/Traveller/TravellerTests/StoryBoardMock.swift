@testable import MVVM_C
import UIKit

class StroyBoardMock: TravellerStoryBoardProtocol {
    var mockViewController: UIViewController?
    func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        mockViewController = UIViewController(nibName: identifier, bundle: nil)
        return mockViewController!
    }
    
    func instantiateInitialViewController() -> UIViewController? {
        mockViewController = UIViewController()
        return mockViewController!
    }
}
