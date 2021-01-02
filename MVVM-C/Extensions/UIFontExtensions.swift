import UIKit

extension UIFont {
    
    static func tabs() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: AppFontSize.tabs.rawValue)!
    }
    
    static func tabsSelected() -> UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: AppFontSize.tabs.rawValue)!
    }
    
    static func small() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: AppFontSize.small.rawValue)!
    }
    
    static func regularFont() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: AppFontSize.regular.rawValue)!
    }
    
    static func regularLightFont() -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: AppFontSize.regular.rawValue)!
    }
    
    static func mediumFont() -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: AppFontSize.regular.rawValue)!
    }
    
    static func mediumLargeFont() -> UIFont {
        return UIFont(name: AppFontName.medium.rawValue, size: AppFontSize.heavy.rawValue)!
    }
    
    static func boldFont() -> UIFont {
        return UIFont(name: AppFontName.bold.rawValue, size: AppFontSize.regular.rawValue)!
    }
    
    static func boldLargeFont() -> UIFont {
        return UIFont(name: AppFontName.bold.rawValue, size: AppFontSize.heavy.rawValue)!
    }
    
    static func lightFont() -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: AppFontSize.light.rawValue)!
    }

    static func lightLarge() -> UIFont {
        return UIFont(name: AppFontName.light.rawValue, size: AppFontSize.heavy.rawValue)!
    }
    
    static func navigationTitle() -> UIFont {
        return UIFont(name: AppFontName.regular.rawValue, size: AppFontSize.navTitle.rawValue)!
    }
    
    static func regularSemiBold() -> UIFont {
        return UIFont(name: AppFontName.semiBold.rawValue, size: AppFontSize.regular.rawValue)!
    }
}

extension UIFont {
    
    static func printFonts() {
        for familyName in UIFont.familyNames {
            print("Font Family = \(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
    }
}
