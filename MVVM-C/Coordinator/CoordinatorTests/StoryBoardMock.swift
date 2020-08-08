@testable import Laso_Care
import UIKit

class StroyBoardMock: CoordinatorStoryBoardProtocol {
    var mockViewController: UIViewController?
    func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        mockViewController = UIViewController(nibName: identifier, bundle: nil)
        return mockViewController!
    }
}
