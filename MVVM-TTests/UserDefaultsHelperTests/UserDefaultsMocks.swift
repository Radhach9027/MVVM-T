@testable import MVVM_T
import UIKit

class UserDefaultsMock: UserDefaultsProtocol {
    var mockVaue: Any?
    var mockDefaultName: String?
    var mockSynchronize: Int = 0
    var mockRemoveObject: Int = 0

    func set(_ value: Any?, forKey defaultName: String) {
         let json = try? JSONSerialization.jsonObject(with: value as! Data, options: .mutableLeaves) as Any
         mockVaue = json
    }
    
    func object(forKey defaultName: String) -> Any? {
        mockDefaultName = defaultName
        if let data = mockVaue {
            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
            return jsonData
        }
        return nil
    }
    
    func synchronize() -> Bool {
        mockSynchronize += 1
        return true
    }
    
    func removeObject(forKey defaultName: String) {
        mockDefaultName = defaultName
        mockRemoveObject += 1
    }
}

class PropertListEncoderMock: PropertListEncoderProtocol {
    func encode<Value>(_ value: Value) throws -> Data where Value : Encodable {
        if let jsonData = try? JSONSerialization.data(withJSONObject:value) {
            return jsonData
        }
        return Data()
    }
}

class PropertyListDecoderMock: PropertyListDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let jsonData = try? JSONDecoder().decode(type, from: data) {
            return jsonData
        }
        return Data() as! T
    }
}
