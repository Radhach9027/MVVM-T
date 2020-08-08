import Foundation

public enum Environment {
    enum Keys {
        enum Plist {
            static let appName = "Bundle name"
            static let appVersion = "APP_VERSION"
            static let endPointUrl = "API_END_URL"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.endPointUrl] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
    static let appVersion: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.appVersion] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let appName: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.appName] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}
