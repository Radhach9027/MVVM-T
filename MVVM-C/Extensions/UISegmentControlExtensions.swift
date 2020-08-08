import UIKit

extension UISegmentedControl {
    class func customSegmentControl() {
        self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.regularFont()], for: .selected)
        self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.regularFont()], for: .normal)
    }
}
