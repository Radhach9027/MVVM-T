import Foundation

protocol UserDefaultsHelperProtocol {
    func set<T : Codable>(for type : T, using key : UserDefaultsKeys)
    func get<T : Codable>(for type : T.Type, using key : UserDefaultsKeys) -> T?
    func setAny(for value: Any, using key: UserDefaultsKeys)
    func getAny<T>(using key: UserDefaultsKeys) -> T?
    func clear(forKey key: UserDefaultsKeys)
    func dataSynchronize()
}

protocol UserDefaultsProtocol: AnyObject {
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    @discardableResult
    func synchronize() -> Bool
    func removeObject(forKey defaultName: String)
}

protocol PropertListEncoderProtocol: AnyObject {
    func encode<Value>(_ value: Value) throws -> Data where Value : Encodable
}

protocol PropertyListDecoderProtocol: AnyObject {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}


extension UserDefaults: UserDefaultsProtocol {}
extension PropertyListEncoder: PropertListEncoderProtocol {}
extension PropertyListDecoder: PropertyListDecoderProtocol {}
