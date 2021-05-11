import Foundation

class Validator {
    
    public static var isValidContact: (String) -> Bool =  {  (phone) in
        let phoneNumberRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: phone)
        return isValidPhone
    }
    
    public static var validateEmailAddress: (String) -> Bool = { (email) in
        let emailTest = NSPredicate(format: "SELF MATCHES %@", String.emailValidationRegEx)
        return emailTest.evaluate(with: email)
    }
    
    public static var validatePassword: (String) -> Bool = { (password) in
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordText = NSPredicate(format:"SELF MATCHES %@ ", passwordRegex)
        return passwordText.evaluate(with: password)
    }
    
    public static func validatePhoneRangeWhenEditing(originalText: String?, typedText: String) -> Bool {
        
        guard let originalText = originalText else { return false }
        if originalText.count == 13 && typedText != "" {
            return false
        }
        
        let inverseSet = CharacterSet(charactersIn:"0123456789").inverted
        let components = typedText.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if (filtered == typedText) {
            return true
        } else {
            if typedText == "." || typedText == "," {
                let countDots = originalText.components(separatedBy:".").count - 1
                let countCommas = originalText.components(separatedBy:",").count - 1
                
                if countDots == 0 && countCommas == 0 {
                    return true
                } else {
                    return false
                }
            } else  {
                return false
            }
        }
    }
}
