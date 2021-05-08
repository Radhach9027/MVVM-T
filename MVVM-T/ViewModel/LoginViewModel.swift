import Foundation
import DependencyContainer

class LoginViewModel {
    
    @Inject var userService: UserServiceProtocol
    @Inject var userManager: UserManagerProtocol
    @Inject var fireBaseSignIn: FirebaseProtocol
    private weak var delegate: LoginViewModelDelegate?
    
    deinit {
        print("LoginViewModel de-init")
    }
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
    
    func socialProfileSignIn(signInType: SocialSignInType, delegate: LoginViewModelDelegate) {
        self.delegate = delegate
        fireBaseSignIn.signIn(signInType: signInType, delgate: self)
    }
}


extension LoginViewModel: FireBaseSignInDelegate {
    
    func signInSuccess() {
        delegate?.signInSuccess()
    }
    
    func signInFailure(_ error: String) {
        delegate?.signInFailure(error)
    }
}
