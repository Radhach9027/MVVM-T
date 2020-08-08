import SwiftKeychainWrapper

struct Keychain<T> where T: Codable {
    
    func storeData(value: T, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            KeychainWrapper.standard.set(data, forKey: key)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func retriveData(key: String) -> T? {
        if let value = KeychainWrapper.standard.string(forKey: key) {
            return value as? T
        }
        return nil
    }
    
    func clearData(key: String) -> Bool {
        let status = KeychainWrapper.standard.removeObject(forKey: key)
        return status
    }
}
