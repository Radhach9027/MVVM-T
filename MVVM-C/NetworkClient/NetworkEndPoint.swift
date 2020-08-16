import UIKit

protocol RequestProvidingProtocol {
    var urlRequest: URLRequest { get }
    var cachePolicy: URLRequest.CachePolicy {get set}
    var timeoutInterval: TimeInterval {get set}
    var httpMethod: String? {get set}
    var httpBody: Data? {get set}
}


enum Endpoint: String {
    case login = "/users"
    case signUp = "/SignUp"
    case forgotPassword = "/ForgotPassword"
    case accessToken = "/AccessToken"
}

enum API {
    static func getUrl(point: Endpoint) -> URL? {
        guard let urlString = try? Configuration.value(for: .baseUrl) + point.rawValue, let url = URL(string: urlString) else {return nil}
        return url
    }
}

extension Endpoint {
    var urlRequest: URLRequest {
        guard let url = API.getUrl(point: .login) else {fatalError("Cannot construct url")}
        return URLRequest(url: url)
    }
}


