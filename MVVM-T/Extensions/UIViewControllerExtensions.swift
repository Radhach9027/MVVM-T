import UIKit

// MARK: ADDING CHILDS & CONSTRAINTS
extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {return}
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func makeViewController<T>(for controller: Destinations, storyBoardName: Stories, storyBoard: UIStoryboard?,  modelPresentationStyle: UIModalPresentationStyle? = nil, modelTransistionStyle: UIModalTransitionStyle? = nil) -> T? where T: UIViewController {
        if let viewController = storyBoard?.instantiateViewController(withIdentifier: controller.rawValue) {
            if let presentation = modelPresentationStyle {
                viewController.modalPresentationStyle = presentation
            }
            if let transistion = modelTransistionStyle {
                viewController.modalTransitionStyle = transistion
            }
            return viewController as? T
        }
        return nil
    }
    
    @discardableResult
    func addConstraints(someController: UIViewController?) -> Bool {
        guard let controller = someController else {return false}
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return true
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
}


// MARK: TEXTFIELD LISTERNERS
protocol TextFieldViewTouchabilityDelegates: AnyObject {
    func rightViewTapped()
}

// MARK: KEYPAD LISTERNERS
protocol KeyBoardListenerDelegates: AnyObject {
    func keyBoardShow(_ notification: Notification)
    func keyBoardHide(_ notification: Notification)
}


// MARK: NAVIGATION
extension UIViewController: TravellerProtocol {}
