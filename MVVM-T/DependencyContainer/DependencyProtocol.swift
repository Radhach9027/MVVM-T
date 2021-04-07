import Foundation

protocol DependencyProtocol {
     func loginDependencies()
}

extension DependencyProtocol {
    
    func loginDependencies() {

        let session = NetworkSession(config: URLSession.configuration(30, nil), queue: URLSession.queue(1, .userInitiated)).session
        
        //***** Add all you'r story dependcies here
        let dependcies = Dependencies {
            Dependency {FirebaseSignIn()}
            Dependency {LoginViewModel()}
            Dependency {UserService()}
            Dependency {UserManager()}
            Dependency {NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: session!)}
        }
        dependcies.build()
    }
}
