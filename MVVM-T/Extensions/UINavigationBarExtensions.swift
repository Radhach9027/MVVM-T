import UIKit

extension UINavigationBar {
    
    static func customNavigation() {
        UINavigationBar.appearance().barTintColor = .indigoColor()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.navigationTitle()]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
