import Foundation

class Authentication {
    var session: UrlSessionProtocol
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    static func generateAccessToken() {
        
    }
    
    static func refreshAccessToken() {
        
    }
    
    static func revokeAccessToken() {
        
    }
}
