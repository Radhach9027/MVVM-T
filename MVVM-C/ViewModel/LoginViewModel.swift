import Foundation

protocol LoginViewModelProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void)
}

class LoginViewModel {
    
    @Inject private var userService: UserServiceProtocol
    @Inject private var userManager: UserManagerProtocol

    init() { print("LoginViewModel init")}
    deinit { print("LoginViewModel de-init")}
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void) {
        
        self.userService.fetchUser(requestType: requestType, completion: { [weak self] (success, error, model) in
            
            if let error = error, model == nil {
                completion(false, error)
                
            } else {

                if let userModel = model as? Users {
                    print("Modify the data accordingly")
                    self?.userManager.createUser(endUser: userModel)
                }
                completion(true, nil)
            }
        })
    }
}
