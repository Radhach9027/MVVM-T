import UIKit

extension String {
    
    func getAge(fromDate: Date, formatter: Date.DateFormats)-> Int {
         let calendar = Calendar.current
         let components = calendar.dateComponents([.year], from: fromDate, to: Date())
         guard let ageYears = components.year else {return 0}
         return ageYears
    }
    
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        let attributes = [NSAttributedString.Key.font:self,]
        let attString = NSAttributedString(string: string,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func fromStringToDate(format: Date.DateFormats, dateStyle: DateFormatter.Style? = nil, timeStyle: DateFormatter.Style? = nil, dateValue: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: dateValue) else {return nil}
        return date
    }
    
    func dateStringToString(actualFormat: Date.DateFormats, convertFormat: Date.DateFormats, dateStyle: DateFormatter.Style? = nil, timeStyle: DateFormatter.Style? = nil, dateValue: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = actualFormat.rawValue
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = convertFormat.rawValue
        if let date = dateFormatter.date(from: dateValue){
            return newFormatter.string(from: date)
        }
        return nil
    }
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    static let emailValidationRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
        "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
    static func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        let ti = NSInteger(interval)
        let ms = Int((interval / 1) * 1000)
        let seconds = ti % 60
        return NSString(format: "%0.2d",seconds)
    }
}
