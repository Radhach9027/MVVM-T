import ReusableComponentsSwift
import UIKit

class ResuableComponents {
    
    static let shared = ResuableComponents()
    private var loadingIndicator: LoadingIndicator?
    private var customPopup: CustomPopup?
    
    private init() {}
    
    func presentAlert(title: String, message: String, controller: UIViewController) {
        Alert.presentAlert(withTitle: title, message: message, controller: controller)
    }

    func presentAlertAction(title: String, message: String, actionTitle: String? = nil, controller: UIViewController, completion: @escaping((UIAlertAction) -> Void)) {
        Alert.presentAlert(withTitle: title, message: message, actionParameters: [AlertParameters(title: actionTitle ?? "Ok", action: { (action) in
            completion(action)
        }, preferredAction: true, actionStyle: .destructive)], controller: controller, style: .alert)
    }
    
    func presentCustomPopup(message: String, animate: CustomPopupAnimateOptions) {
        customPopup = CustomPopup(window: UIWindow.window!)
        customPopup?.present(message: message, animate: animate)
    }
    
    func slideView(messgae: String, position: AnimatePosition = .top, controller: UIViewController) {
        AnimatedView.shared.present(message: .message(messgae), postion: position, bgColor: .indigoColor(), controller: controller)
    }
    
    func presentLoadingIndicator(steps: LoadingSteps) {
         loadingIndicator = LoadingIndicator(window: UIWindow.window!)
         loadingIndicator?.loading(step: steps)
    }
    
    func dismissLoadingIndicator(steps: LoadingSteps) {
        loadingIndicator?.loading(step: steps)
    }
}
