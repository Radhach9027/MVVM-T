@testable import MVVM_C
import UIKit

class UserDefaultsMock: UserDefaultsProtocol{
    var mockVaue: Any?
    var mockDefaultName: String?
    var mockSynchronize: Int = 0
    var mockRemoveObject: Int = 0

    func set(_ value: Any?, forKey defaultName: String) {
        mockVaue = value
    }
    
    func object(forKey defaultName: String) -> Any? {
        mockDefaultName = defaultName
        return nil
    }
    
    func synchronize() -> Bool {
        mockSynchronize += 1
        return true
    }
    
    func removeObject(forKey defaultName: String) {
        mockRemoveObject += 1
    }
}

class PropertListEncoderMock: PropertListEncoderProtocol {
    func encode<Value>(_ value: Value) throws -> Data where Value : Encodable {
        return Data()
    }
}

class PropertyListDecoderMock: PropertyListDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        return type as! T
    }
}
