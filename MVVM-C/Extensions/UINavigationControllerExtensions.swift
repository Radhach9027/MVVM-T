import UIKit

extension UINavigationController {
      func setTransparentBar(){
        UINavigationController().navigationBar.setBackgroundImage(UIImage(), for: .default)
        UINavigationController().navigationBar.shadowImage = UIImage()
        UINavigationController().navigationBar.isTranslucent = true
    }
}
