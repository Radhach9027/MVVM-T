import Foundation
import UIKit

protocol LoginViewModelProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void)
    func socialProfileSignIn(signInType: SocialSignInType)
    var  _delgate: LoginViewModelDelegate? { get set}
}

protocol LoginViewModelDelegate: AnyObject {
    func signInSuccess()
    func signInFailure(_ error: String)
}

class LoginViewModel {
    
    @Inject private var userService: UserServiceProtocol
    @Inject private var userManager: UserManagerProtocol
    private var fireBaseSignIn: FirebaseSignIn?
    private weak var delegate: LoginViewModelDelegate?
    
    init() {
        print("LoginViewModel init")
        fireBaseSignIn = FirebaseSignIn(delegate: self)
    }
    
    deinit {
        print("LoginViewModel de-init")
        _delgate = nil
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    var _delgate: LoginViewModelDelegate? {
        set {
            self.delegate = newValue
        }
        
        get {
            return self.delegate
        }
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
        fireBaseSignIn?.signIn(signInType: signInType)
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
