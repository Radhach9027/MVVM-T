import Foundation

class LoginViewModel: NetworkClient {
    var session: UrlSessionProtocol
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func loginUser(completion: @escaping (Result<LoginModel?, NetworkErrorCode>)-> Void) {
        var request: URLRequest = Endpoint.login.urlRequest
        request.httpMethod = "GET"
        fetch(with: request, networkType: .dataTask, decode: { json -> LoginModel? in
            guard let result = json as? LoginModel else { return  nil }
            return result
        }, completion: completion)
    }
}

struct Users: Codable {
    var id: Int
    var email: String
    var first_name: String
    var last_name: String
    var avatar: String
}
struct LoginModel: Codable {
    var data: [Users]
}
