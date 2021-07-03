import Foundation

final class UserDefaultsHelper: NSObject, UserDefaultsHelperProtocol {
    var userDefaults: UserDefaultsProtocol?
    var encoder: PropertListEncoderProtocol?
    var decoder: PropertyListDecoderProtocol?
    
    init(userDefaults: UserDefaultsProtocol?, encoder: PropertListEncoderProtocol?, decoder: PropertyListDecoderProtocol?) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func set<T : Codable>(for type : T, using key : UserDefaultsKeys) {
        let encodedData = try? self.encoder?.encode(type)
        self.userDefaults?.set(encodedData, forKey: key.rawValue)
        dataSynchronize()
    }
    
    func get<T : Codable>(for type : T.Type, using key : UserDefaultsKeys) -> T? {
        guard let data = self.userDefaults?.object(forKey: key.rawValue) as? Data else {return nil}
        let decodedObject = try? self.decoder?.decode(type, from: data)
        return decodedObject
    }
    
    func setAny(for value: Any, using key: UserDefaultsKeys) {
        self.userDefaults?.set(value, forKey: key.rawValue)
        dataSynchronize()
    }
    
    func getAny<T>(using key: UserDefaultsKeys) -> T? {
        if let value = self.userDefaults?.object(forKey: key.rawValue) as? T {
            return value
        }
        return nil
    }
    
    func dataSynchronize() {
        self.userDefaults?.synchronize()
    }
    
    func clear(forKey key: UserDefaultsKeys) {
        self.userDefaults?.removeObject(forKey: key.rawValue)
        dataSynchronize()
    }
}
