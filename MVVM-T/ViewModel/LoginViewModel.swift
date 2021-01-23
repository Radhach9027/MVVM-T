import Foundation

class LoginViewModel {
    
    @Inject private var userService: UserServiceProtocol
    @Inject private var userManager: UserManagerProtocol
    @Inject private var fireBaseSignIn: FirebaseProtocol
    
    private weak var delegate: LoginViewModelDelegate?
    
    init() {
        print("LoginViewModel init")
    }
    
    deinit {
        print("LoginViewModel de-init")
        _delgate = nil
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    var _delgate: LoginViewModelDelegate? {
        
        set { self.delegate = newValue }
        get { return self.delegate }
    }
    
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
    
    func socialProfileSignIn(signInType: SocialSignInType) {
        fireBaseSignIn._delgate = self
        fireBaseSignIn.signIn(signInType: signInType)
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
