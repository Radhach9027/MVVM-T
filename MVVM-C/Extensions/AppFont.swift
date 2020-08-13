import UIKit

struct AppFontName {
    static let regular = "KohinoorTelugu-Regular"
    static let medium = "KohinoorTelugu-Medium"
    static let bold = "KohinoorGujarati-Bold"
    static let light = "KohinoorTelugu-Light"
}

enum AppFontSize: CGFloat {
    case tabs = 11.0
    case small = 12.0
    case regular  = 15.0
    case heavy = 17.0
}

extension UIFont {
    
    static func tabs() -> UIFont {
        return UIFont(name: AppFontName.regular, size: AppFontSize.tabs.rawValue)!
    }
    
    static func tabsSelected() -> UIFont {
           return UIFont(name: AppFontName.bold, size: AppFontSize.tabs.rawValue)!
    }
    
    static func small() -> UIFont {
        return UIFont(name: AppFontName.regular, size: AppFontSize.small.rawValue)!
    }
    
    static func regularFont() -> UIFont {
        return UIFont(name: AppFontName.regular, size: AppFontSize.regular.rawValue)!
    }
    
    static func mediumFont() -> UIFont {
          return UIFont(name: AppFontName.medium, size: AppFontSize.regular.rawValue)!
    }
    
    static func mediumLargeFont() -> UIFont {
          return UIFont(name: AppFontName.medium, size: AppFontSize.heavy.rawValue)!
    }
    
    static func boldFont() -> UIFont {
          return UIFont(name: AppFontName.bold, size: AppFontSize.regular.rawValue)!
    }
    
    static func boldLargeFont() -> UIFont {
          return UIFont(name: AppFontName.bold, size: AppFontSize.heavy.rawValue)!
    }
    
    static func lightFont() -> UIFont {
          return UIFont(name: AppFontName.light, size: AppFontSize.regular.rawValue)!
    }

    static func lightLarge() -> UIFont {
          return UIFont(name: AppFontName.light, size: AppFontSize.heavy.rawValue)!
    }
}