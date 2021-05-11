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
    }
    
    static func loginDependencies() {
        _Dependencies.dependcies.build()
    }
    
    static func clearDependencies() {
        //_Dependencies.dependcies.remove()
    }
}
