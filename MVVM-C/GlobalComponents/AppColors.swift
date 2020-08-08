import UIKit

extension UIColor {
    
    func regular() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    func medium() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    func bold() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    func light() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    func appColor() -> UIColor {
        return UIColor(named: "AppTheme") ?? UIColor.init(red: 112/255, green: 199/255, blue: 195/255, alpha: 1)
    }
    
    func appColor2() -> UIColor {
        return UIColor.darkGray
    }
}
