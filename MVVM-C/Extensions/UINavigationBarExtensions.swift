import UIKit

extension UINavigationBar {
    class func customNavigation() {
        self.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.mediumFont()]
        self.appearance().tintColor = UIColor().appColor()
    }
}
