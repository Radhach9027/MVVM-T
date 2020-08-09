import Foundation

protocol UserDefaultsHelperProtocol {
    func set<T : Codable>(for type : T, using key : UserDefaultsKeys)
    func get<T : Codable>(for type : T.Type, using key : UserDefaultsKeys) -> T?
    func clear(forKey key: UserDefaultsKeys)
    func dataSynchronize()
}

enum UserDefaultsKeys: String {
    case storeStack
}

class UserDefaultsHelper: NSObject, UserDefaultsHelperProtocol {
    let defaults: UserDefaults = UserDefaults.standard
    
    func set<T : Codable>(for type : T, using key : UserDefaultsKeys) {
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key.rawValue)
        dataSynchronize()
    }
    
    func get<T : Codable>(for type : T.Type, using key : UserDefaultsKeys) -> T? {
        guard let data = defaults.object(forKey: key.rawValue) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }
    
    func dataSynchronize() {
        defaults.synchronize()
    }
    
    func clear(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
        dataSynchronize()
    }
}
