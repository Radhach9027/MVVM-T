import Foundation

enum UserDefaultsKeys: String {
    case storeStack
}

class UserDefaultsHelper: NSObject, UserDefaultsHelperProtocol {
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
    
    func dataSynchronize() {
        self.userDefaults?.synchronize()
    }
    
    func clear(forKey key: UserDefaultsKeys) {
        self.userDefaults?.removeObject(forKey: key.rawValue)
        dataSynchronize()
    }
}
