import Foundation

protocol LoginViewModelProtocol {
    func loginUser(loginType: LoginType, completion: @escaping (Result<LoginModel?, NetworkErrorCode>)-> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    
    var loginService: LoginServiceProtocol?
    init(loginService: LoginServiceProtocol? = LoginService()) {
        self.loginService = loginService
    }
    
    func loginUser(loginType: LoginType, completion: @escaping (Result<LoginModel?, NetworkErrorCode>)-> Void) {
        
        switch loginType {
        case .phone:
            self.loginService?.loginUserWithPhone(completion: completion)
        default:
            break
        }
    }
}
