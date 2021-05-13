import UIKit

extension UIColor {
    
    public static func regular() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    public static func medium() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    public static func bold() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    public static func light() -> UIColor{
        return UIColor.init(red: 22/255, green: 45/255, blue: 65/255, alpha: 1)
    }
    
    public static func appColor() -> UIColor {
        return UIColor(named: "AppTheme") ?? UIColor.init(red: 112/255, green: 199/255, blue: 195/255, alpha: 1)
    }
    
    public static func appViewBackgroundColor() -> UIColor {
        return UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
    
    public static func appButtonColor() -> UIColor {
        return UIColor.init(red: 1/255, green: 183/255, blue: 216/255, alpha: 1)
    }
    
    public static func borderLineColor() -> UIColor {
        return UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    }
    
    public static func mainContentColor() -> UIColor {
           return UIColor.init(red: 37/255, green: 62/255, blue: 67/255, alpha: 1)
    }
    
    public static func detailContentColor() -> UIColor {
           return UIColor.init(red: 77/255, green: 102/255, blue: 106/255, alpha: 1)
    }
    
    public static func tabsNormal() -> UIColor {
        return .lightGray
    }
    
    public static func tabsSelected() -> UIColor {
        return .white
    }
    
    public static func indigoColor() -> UIColor {
        return .systemIndigo
    }
    
    public static func red() -> UIColor {
        return .systemRed
    }
}
