import Foundation

protocol AuthenticationProtocol {
    static func generateAccessToken()
    static func refreshAccessToken()
    static func revokeAccessToken()
}

class Authentication: AuthenticationProtocol  {
    
    static func generateAccessToken() {
    }
    
    static func refreshAccessToken() {
    }
    
    static func revokeAccessToken() {
    }
}
