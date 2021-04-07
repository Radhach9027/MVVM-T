import Foundation
import DependencyContainer

protocol DependencyProtocol {
     func loginDependencies()
}

extension DependencyProtocol {
    
    func loginDependencies() {

        let session = NetworkSession(config: URLSession.configuration(30, nil), queue: URLSession.queue(1, .userInitiated)).session
        
        let fireBase: FirebaseProtocol = FirebaseSignIn()
        let loginViewModel: LoginViewModelProtocol = LoginViewModel()
        let userService: UserServiceProtocol = UserService()
        let userManager: UserManagerProtocol = UserManager()

        //***** Add all you'r story dependcies here
        let dependcies = Dependencies {
            Dependency {fireBase}
            Dependency {loginViewModel}
            Dependency {userService}
            Dependency {userManager}
            Dependency {NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: session!)}
        }
        dependcies.build()
    }
}
