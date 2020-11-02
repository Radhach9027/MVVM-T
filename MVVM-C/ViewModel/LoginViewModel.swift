import Foundation

protocol LoginViewModelProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void)
}

class LoginViewModel {
    
    private var userService: UserServiceProtocol?
    private var userManager: UserManagerProtocol?
    
    init(userService: UserServiceProtocol? = UserService(),  userManager:UserManagerProtocol? = UserManager()) {
        self.userService = userService
        self.userManager = userManager
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void) {
        self.userService?.fetchUser(requestType: requestType, completion: { [weak self] (success, error, model) in
            
            if let error = error, model == nil {
                completion(false, error)
                
            } else {

                if let userModel = model as? Users {
                    print("Modify the data accordingly")
                    self?.userManager?.createUser(endUser: userModel)
                }
                completion(true, nil)
            }
        })
    }
}
