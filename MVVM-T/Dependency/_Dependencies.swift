import Foundation
import DependencyContainer

protocol DependencyProtocol {
    static func loginDependencies()
    static func clearDependencies()
}

struct _Dependencies: DependencyProtocol {
    
    //***** Add all you'r story dependcies here

    private static let dependcies = Dependencies {
        Dependency {FirebaseSignIn() as FirebaseProtocol}
        Dependency {LoginViewModel() as LoginViewModelProtocol}
        Dependency {UserService() as UserServiceProtocol}
        Dependency {UserManager() as UserManagerProtocol}
        Dependency {NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: NetworkSession(config: URLSession.configuration(30, nil), queue: URLSession.queue(1, .userInitiated)).session!)}
    }
    
    static func loginDependencies() {
        _Dependencies.dependcies.build()
    }
    
    static func clearDependencies() {
        //_Dependencies.dependcies.remove()
    }
}
