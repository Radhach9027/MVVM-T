import ReusableComponentsSwift
import UIKit

class ResuableComponents {
    
    static let shared = ResuableComponents()
    
    private init() {
        //LoadingIndicator.shared.config(window: UIWindow.window!)
    }
    
    func presentAlert(title: String, message: String, controller: UIViewController) {
        Alert.presentAlert(withTitle: title, message: message, controller: controller)
    }

    func presentAlertAction(title: String, message: String, actionTitle: String? = nil, controller: UIViewController, completion: @escaping((UIAlertAction) -> Void)) {
        Alert.presentAlert(withTitle: title, message: message, actionParameters: [AlertParameters(title: actionTitle ?? "Ok", action: { (action) in
            completion(action)
        }, preferredAction: true, actionStyle: .destructive)], controller: controller, style: .alert)
    }
    
    func presentCustomPopup(message: String, animate: CustomPopupAnimateOptions) {
        CustomPopup.shared.present(message: message, animate: animate)
    }
    
    func slideView(messgae: String, position: AnimatePosition = .top, controller: UIViewController) {
        AnimatedView.shared.present(message: .message(messgae), postion: position, bgColor: .indigoColor(), controller: controller)
    }
    
    func presentLoadingIndicator(steps: LoadingSteps) {
        LoadingIndicator.shared.config(window: UIWindow.window!)
        LoadingIndicator.shared.loading(step: steps)
    }
}
