import UIKit

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

extension Endpoint: RequestProvidingProtocol {
    var urlRequest: URLRequest {
        guard let url = API.getUrl(point: self) else {fatalError("Cannot construct url")}
        return URLRequest(url: url)
    }
}


