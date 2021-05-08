import SwiftKeychainWrapper
import Foundation

struct Keychain<T> where T: Codable {
    
    static func storeData(value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            KeychainWrapper.standard.set(data, forKey: key)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static func retriveData(key: String) -> T? {
        if let value = KeychainWrapper.standard.data(forKey: key) {
            return value as? T
        }
        return nil
    }
    
    @discardableResult
    static func clearData(key: String) -> Bool {
        let status = KeychainWrapper.standard.removeObject(forKey: key)
        return status
    }
}


