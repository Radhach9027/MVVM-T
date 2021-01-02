import UIKit

extension UIWindow {
    
    static var window: UIWindow? {
        if #available(iOS 13, *) {
            var window: UIWindow?
            window = UIApplication.shared.windows.first { $0.isKeyWindow }
            if window == nil {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene  {
                    window = UIWindow(windowScene: windowScene)
                    return window
                }
            }
            return window
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    class func getTopViewController(base: UIViewController? = window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
