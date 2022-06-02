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
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (ServiceResult)-> Void) {
        userService.fetchUser(requestType: requestType,
                              completion: completion) // if you want to perform any storage operations or response manipluations, open the block
    }
    
    func socialProfileSignIn(signInType: SocialSignInType, delegate: LoginViewModelDelegate) {
        self.delegate = delegate
        fireBaseSignIn.signIn(signInType: signInType,
                              delgate: self)
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
