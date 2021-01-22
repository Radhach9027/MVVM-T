import UIKit

extension UITabBarItem {
    class func customTabBarItems() {
        self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.tabsSelected(), NSAttributedString.Key.font: UIFont.tabsSelected()], for: .selected)
        self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.tabsNormal(), NSAttributedString.Key.font: UIFont.tabs()], for: .normal)
    }
}

protocol BarButtonItemConfiguration: class {
    func addBarButtonItem(ofType type: BarButtonItemType, imageType: BarButtonImageType)
}

@objc protocol BarButtonActions {
    @objc func showNotification(_ sender:AnyObject)
}

extension BarButtonItemConfiguration where Self: UIViewController, Self: BarButtonActions {
    func addBarButtonItem(ofType type: BarButtonItemType, imageType: BarButtonImageType) {
        func newButton(imageName: String, position: BarButtonItemPosition, action: Selector?) {
            let button = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: action)
            switch position {
            case .left: self.navigationItem.leftBarButtonItem = button
            case .right: self.navigationItem.rightBarButtonItem = button
            }
        }
        
        switch type {
        case .notification(let p): newButton(imageName: imageType.rawValue, position: p, action: #selector(Self.showNotification(_:)))
        }
    }
}

protocol BarButtonConfigarable: BarButtonItemConfiguration, BarButtonActions {}

