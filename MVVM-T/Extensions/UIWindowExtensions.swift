import UIKit
import ReusableComponentsSwift

// MARK: KEY WINDOW & TOP VIEWCONTROLLER
extension UIWindow {
    
    static var window: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate), let window = sceneDelegate.window {
            return window
        }
        return nil
    }
    
    static var topViewController: UIViewController? {
        
        if let nav = window?.rootViewController as? UINavigationController {
            return nav.topViewController
        } else if let tab = window?.rootViewController as? UITabBarController, let selected = tab.selectedViewController {
            return selected
        } else if let presented = window?.rootViewController?.presentedViewController {
            return presented
        }
        return nil
    }
}


// MARK: LOADING INDICATOR
extension UIWindow {
    
    static func showLoading(steps: LoadingSteps) {
        switch steps {
            case .start:
                LoadingIndicator.shared.config(window: UIWindow.window!)
            default:
                break
        }
        LoadingIndicator.shared.loading(step: steps)
    }
}

// MARK: CUSTOM POP-UP
extension UIWindow {
    static func showPopup(message: String, animate: CustomPopupAnimateOptions) {
        CustomPopup(window: UIWindow.window!).present(message: message, animate: animate)
    }
}


// MARK: ALERT VIEW
extension UIWindow {
    
    static func showAlert(message: String, title: String = "Alert") {
        Alert.presentAlert(withTitle: title, message: message, controller: UIWindow.topViewController!)
    }
    
    static func showAlertAction(title: String = "Alert", message: String, actionTitle: String? = nil, controller: UIViewController = UIWindow.topViewController!, completion: @escaping((UIAlertAction) -> Void)) {
        Alert.presentAlert(withTitle: title, message: message, actionParameters: [AlertParameters(title: actionTitle ?? "Ok", action: { (action) in
            completion(action)
        }, preferredAction: true, actionStyle: .destructive)], controller: controller, style: .alert)
    }
}

// MARK: SLIDE VIEW
extension UIWindow {
    
    static func showSlideView(message: String, position: AnimatePosition) {
        AnimatedView.shared.present(message: .message(message), postion: position, bgColor: .indigoColor(), controller: UIWindow.topViewController!)
    }
}
