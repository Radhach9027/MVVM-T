import UIKit

extension UIView {
    func customBackgroundColor() {
        UIView().backgroundColor = UIColor.appViewBackgroundColor()
    }
    
    var customBottomHeight: CGFloat {
        if let controller = self.getViewController(), let tabBar = controller.tabBarController?.tabBar {
            let padding: CGFloat = 10.0
            let minusHeight = (self.frame.size.height - (tabBar.frame.origin.y + tabBar.frame.size.height))
            return tabBar.frame.size.height + minusHeight + padding
        }
        return 0
    }
}

extension UIView {
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeSubscribers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func subscribeTextFieldNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPasswordhint), name: Notification.Name.textFieldRightViewPressed, object: nil)
    }
    
    func removeTextFieldSubscribers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.textFieldRightViewPressed, object: nil)
    }
}

extension UIView {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let topController = self.getViewController()
        print("Set the selected delegate in controller and call from here = \(String(describing: topController))")
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let topController = self.getViewController()
        print("Set the selected delegate in controller and call from here = \(String(describing: topController))")
    }
    
    @objc func showPasswordhint() {
    }
}

extension UIView {
    
    func tabItemBounceAnimation() {
        let timeInterval: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        propertyAnimator.addAnimations({ self.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
