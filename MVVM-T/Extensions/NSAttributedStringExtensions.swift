import UIKit

extension NSAttributedString {
    
    static func generateAttributedString(mainString: String, attributedString: String, defaultFont: UIFont, attributeFont: UIFont, defaultColor: UIColor, attributeColor: UIColor) -> NSAttributedString {
        let regularAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: defaultColor, .font: defaultFont]
        let largeAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: attributeColor, .font: attributeFont]
        let attributedSentence = NSMutableAttributedString(string: mainString, attributes: regularAttributes)
        if let range: Range<String.Index> = mainString.range(of: attributedString) {
            let index: Int = mainString.distance(from: attributedString.startIndex, to: range.lowerBound)
             attributedSentence.setAttributes(largeAttributes, range: NSRange(location: index, length: attributedString.count))
        }
        return attributedSentence
    }
}
