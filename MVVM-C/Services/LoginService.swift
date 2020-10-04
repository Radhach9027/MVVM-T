import Foundation

enum LoginType {
    case phone, email, google, facebook
}

protocol LoginServiceProtocol {
    func loginUserWithPhone(completion: @escaping (Result<LoginModel?, NetworkErrorCode>)-> Void)
}

class LoginService: NetworkClient, LoginServiceProtocol {
    var session: UrlSessionProtocol
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func loginUserWithPhone(completion: @escaping (Result<LoginModel?, NetworkErrorCode>)-> Void) {
        var request: URLRequest = Endpoint.login.urlRequest
        request.httpMethod = "GET"
        fetch(with: request, networkType: .dataTask, decode: { json -> LoginModel? in
            guard let result = json as? LoginModel else { return  nil }
            return result
        }, completion: completion)
    }
}

