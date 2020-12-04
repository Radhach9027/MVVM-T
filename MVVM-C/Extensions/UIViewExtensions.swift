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
    
    func dismiss(animate: CustomPopupAnimateOptions) {
        
        switch animate {
        case .affineIn:
            dismissTransfromAffine(view: self)
        case .crossDisolve:
            dismissCrossDisolve(view: self)
        case .affineOut:
            dismissTransfromAffineOut(view: self)
        case .bounce:
            dismissTransformBounce(view: self)
        }
    }
    
    func animate(animate: CustomPopupAnimateOptions) {
        
        switch animate {
        case .affineIn:
            transfromToAffine(view: self)
        case .crossDisolve:
            transfromToCrossDisolve(view: self)
        case .affineOut:
            transfromToAffineOut(view: self)
        case .bounce:
            transformToBounce(view: self)
        }
    }
    
    func transfromToAffine(view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 1
                view.transform = .identity
            })
        }
    }
    
    func transfromToAffineOut(view: UIView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            UIView.animate(withDuration: 0.5, animations: {
                view.transform = .identity
            })
        }
    }
    
    func transfromToCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration: 1.5, options: .transitionCrossDissolve, animations: {
            view.alpha = 1
        }, completion: nil)
    }
    
    func transformToBounce(view: UIView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 2.0,
                       initialSpringVelocity: 2.0,
                       options: [],
                       animations: {
                        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        view.alpha = 1
                       }, completion: {
                        (value: Bool) in
                        UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
                            view.transform = .identity
                        }
                        )
                       })
    }
    
    func dismissTransfromAffineOut(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            view.alpha = 0.5
        }) { (true) in
            view.alpha = 1
            self.removeFromSuperview()
        }
    }
    
    func dismissTransfromAffine(view: UIView) {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            view.alpha = 0.5
        }) { (true) in
            view.alpha = 0
            self.removeFromSuperview()
        }
    }
    
    func dismissCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration:1.5, options: .transitionCrossDissolve, animations: {
            view.alpha = 0
        }){ (true) in
            view.alpha = 1
            self.removeFromSuperview()
        }
    }
    
    func dismissTransformBounce(view: UIView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 2.0,
                       initialSpringVelocity: 2.0,
                       options: [],
                       animations: {
                        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        view.alpha = 1
                       }, completion: {
                        (value: Bool) in
                        view.transform = .identity
                        UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
                            view.alpha = 1
                            self.removeFromSuperview()
                        }
                        )
                       })
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
        print("Pass this delegate to respective controller")
    }
}
