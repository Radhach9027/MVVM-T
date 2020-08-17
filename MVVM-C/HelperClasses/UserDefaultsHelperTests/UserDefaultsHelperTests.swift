@testable import Laso_Care
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
    
    func testUserDefaultsSetValue_shouldReturn_expectedValue() {
        let storeData = ["one", "two", "three"]
        userDefaultsHelper?.set(for: storeData, using: .storeStack)
        if let mockValue = mockUserDefaults.mockVaue as? [String] {
            XCTAssertEqual(storeData, mockValue)
            XCTAssertEqual(mockUserDefaults.mockSynchronize, 1)
        }
    }
    
    func testUserDefaultsGetValue_shouldReturn_expectedValue() {
        let storeData = ["one", "two", "three"]
        userDefaultsHelper?.set(for: storeData, using: .storeStack)
        let mockObj = userDefaultsHelper?.get(for: [String].self, using: .storeStack)
        XCTAssertEqual(mockObj, storeData)
    }
    
    func testUserDefaultsClearValue_shouldReturn_expectedValue() {
        userDefaultsHelper?.clear(forKey: .storeStack)
        XCTAssertEqual(mockUserDefaults.mockDefaultName, UserDefaultsKeys.storeStack.rawValue)
        XCTAssertEqual(mockUserDefaults.mockRemoveObject, 1)
    }
}
