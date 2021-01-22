import Foundation
import UIKit

protocol BaseNavigation {
    func dismissController(animated: Bool, dismissed: @escaping ((Bool) -> Void))
    func popToRoot(to root: Bool)
}

protocol LaunchScreenNavigationProtocol: BaseNavigation {
    func pushToLogin()
    func presentSignUp()
    func pushToForgotpassword()
}

extension LaunchScreenNavigationProtocol {

    func pushToLogin() {
        Traveller.route.push(story: .login, controller: .login, animated: true, hidesBottomBar: false, modelTransistion: .crossDissolve, modelPresentation: .none).perform()
    }
    
    func presentSignUp() {
        Traveller.route.present(story: .login, controller: .signup, animated: true, modelTransistion: .crossDissolve, modelPresentation: .fullScreen).perform { (controller: SignupViewController) in
            controller.title = "Sign Up"
        }
    }
    
    func dismissController(animated: Bool, dismissed: @escaping ((Bool) -> Void)) {
        Traveller.route.dismiss(modelTransistionStyle: .crossDissolve, animated: animated, dismissed: dismissed).perform()
    }
    
    
    func pushToForgotpassword() {
        Traveller.route.push(story: .login, controller: .forgotPassword, animated: true, hidesBottomBar: false, modelTransistion: .coverVertical, modelPresentation: .none).perform { (controller) in
            controller.title = "Details"
        }
    }
    
    func popToRoot(to root: Bool) {
        Traveller.route.pop(toRootController: root, animated: true, modelTransistionStyle: .crossDissolve).perform()
    }
}