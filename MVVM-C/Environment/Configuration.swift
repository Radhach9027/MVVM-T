import Foundation

enum Configuration {
    
    enum ConfigurationKeys: String {
        case baseUrl = "APP_API_BASE_URL"
        case appName = "APP_BUNDLE_NAME"
        case appVersion = "APP_VERSION"
        case bundleId = "APP_BUNDLE_ID"
        case apiKey = "APP_API_KEY"
    }
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: ConfigurationKeys) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key.rawValue) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
