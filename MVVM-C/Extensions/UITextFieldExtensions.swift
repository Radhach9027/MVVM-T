import UIKit

extension UITextField {
    
     func addBottomBorder(color: UIColor = .borderLineColor(), marginToUp: CGFloat = 10.00, height: CGFloat = 1.00){
        
        let bottomLine = CALayer()
         bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - marginToUp, width: self.frame.size.width - 38, height: height)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
