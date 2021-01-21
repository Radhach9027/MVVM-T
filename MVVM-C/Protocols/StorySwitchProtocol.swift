import UIKit

protocol StorySwitchProtocol {
    func switchToHome()
    func switchToLaunch()
}

extension StorySwitchProtocol {
    
    func switchToHome() {
        let story = UIStoryboard(name: "TabBar", bundle: nil)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .tab, animated: true, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
    
    func switchToLaunch() {
        loginDependencies()
        let story = UIStoryboard(name: "Login", bundle: nil)
        Traveller.route.switchRootViewController(storyBoard: story, controllerDestination: .launch, animated: true, window: UIWindow.window, modelTransistion: .transitionCrossDissolve).perform()
    }
}

private extension StorySwitchProtocol {
    
    func loginDependencies() {

        let session = NetworkSession(config: URLSession.configuration(30, nil), queue: URLSession.queue(1, .userInitiated)).session
        
        //***** Add all you'r story dependcies here
        let dependcies = Dependencies {
            Dependency {LoginViewModel()}
            Dependency {UserService()}
            Dependency {UserManager()}
            Dependency {NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: session!)}
        }
        dependcies.build()
    }
    
    func tabBarDependencies() {
    }
}
