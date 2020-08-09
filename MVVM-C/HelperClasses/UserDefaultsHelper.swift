import Foundation

protocol UserDefaultsHelperProtocol {
    func set(_ value: Any?, forKey key: UserDefaultsKeys)
    func get(forKey key: UserDefaultsKeys) -> Any?
    func clear(forKey key: UserDefaultsKeys)
    func dataSynchronize()
}

enum UserDefaultsKeys: String {
    case storeStack
}

class UserDefaultsHelper: NSObject, UserDefaultsHelperProtocol {
    let defaults: UserDefaults = UserDefaults.standard
    
    func set(_ value: Any?, forKey key: UserDefaultsKeys) {
        defaults.set(value, forKey: key.rawValue)
        dataSynchronize()
    }
    
    func get(forKey key: UserDefaultsKeys) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    func dataSynchronize() {
        defaults.synchronize()
    }
    
    func clear(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
        dataSynchronize()
    }
}

extension UserDefaults {
    func decode<T : Codable>(for type : T.Type, using key : String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T : Codable>(for type : T, using key : String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
