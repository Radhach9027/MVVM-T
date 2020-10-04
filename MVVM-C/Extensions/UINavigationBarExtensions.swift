import UIKit

extension UINavigationBar {
    
    static func customNavigation() {
        self.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.navigationTitle()]
        self.appearance().tintColor = UIColor.appColor()
    }
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}

extension UIBarButtonItem {
    
    static func CustomBarButtonItems() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.navigationTitle()], for: .normal)
    }
}
