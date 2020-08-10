@testable import MVVM_C
import XCTest

class UserDefaultsHelperTests: XCTestCase {
    var userDefaultsHelper: UserDefaultsHelperProtocol?
    
    var mockUserDefaults = UserDefaultsMock()
    var mockEncoder: PropertListEncoderProtocol = PropertListEncoderMock()
    var mockDecoder: PropertyListDecoderProtocol = PropertyListDecoderMock()

    override func setUp() {
        super.setUp()
        userDefaultsHelper = UserDefaultsHelper(userDefaults: mockUserDefaults, encoder: mockEncoder, decoder: mockDecoder)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
}
