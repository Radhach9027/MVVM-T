import UIKit

class CustomPopup: UIView, Nib {
    
    private static var sharedInstance: CustomPopup?
    class var shared : CustomPopup {
        
        guard let instance = self.sharedInstance else {
            let strongInstance = CustomPopup()
            self.sharedInstance = strongInstance
            return strongInstance
        }
        return instance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
    
    private init() {
        super.init(frame: .zero)
        loadNibFile()
        headerBgView.clipsToBounds = true
        headerBgView.layer.cornerRadius = 10
        headerBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet weak var customPopView: CustomView!
    @IBOutlet weak var headerBgView: CustomImageView!
    @IBOutlet weak var headerCircularView: CustomView!
    @IBOutlet weak var headerCircularImageView: CustomImageView!
    @IBOutlet weak var dismissButton: CustomButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    private var currentState: CustomPopupAnimateOptions = .affineIn
}

extension CustomPopup {
    
    func loadNibFile() {
        registerNib()
    }
    
    func present(message: String, animate: CustomPopupAnimateOptions) {
        self.messageLabel.text = message
        self.currentState = animate
        self.customPopView.animate(animate: animate)
    }
}

private extension CustomPopup {
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.customPopView.dismiss(animate: currentState)
    }
}
