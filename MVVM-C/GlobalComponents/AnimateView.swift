import UIKit

enum AnimatePosition {
    case top, bottom, middle
}

enum AnimatedMessages: String {
    case internet = "Hey Seems to have good internet connectivity..Let's ride the app..😃"
    case noInternet = "As it seems there is no network connection available on the device, please check and try again..😟"
    case error = "Oops...Something went wrong, Please try again."
    
    func AnimatedIcons () -> UIImage {
        switch self {
        case .noInternet:
            return UIImage(named: "NoInternet")!
        case .internet:
            return UIImage(named: "Internet")!
        case .error:
            return UIImage(named: "error")!
        }
    }
    
    func apiError(message: Error)-> String{
        return message.localizedDescription
    }
}

enum Transform {
    case show
    case hide
}

class AnimatedView: UIView {
    let actualHeight: CGFloat = 60
    lazy var titleLabel: (UIColor, String) -> UILabel = { (textColor, title) in
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    lazy var iconType:(UIImage) -> UIImageView = { (image) in
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    lazy var viewHeight:(AnimatedMessages) -> CGFloat = { (message) in
        let size = message.rawValue.sizeOfString(string: message.rawValue, constrainedToWidth: Double(UIScreen.main.bounds.size.width - self.actualHeight))
        return size.height < self.actualHeight ? self.actualHeight : size.height + self.actualHeight
    }
    
    init(message: AnimatedMessages, postion: AnimatePosition, bgColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.show(hide: true)
        addConstrints(postion: postion, message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AnimatedView {
    
    func addConstrints(postion: AnimatePosition, message: AnimatedMessages) {
        defer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.transfrom(with: .show)
            }
        }
        guard let rootView = UIWindow.getTopViewController()?.view else { return }
        let icon: UIImageView = self.iconType(AnimatedMessages.AnimatedIcons(message)())
        let titleLabel: UILabel = self.titleLabel(.white, message.rawValue)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(icon)
        self.addSubview(titleLabel)
        rootView.addSubview(self)
        
        
        switch postion {
        case .top:
            self.topAnchor.constraint(equalTo: rootView.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
            break
        case .bottom:
            self.topAnchor.constraint(equalTo: rootView.layoutMarginsGuide.bottomAnchor, constant: -self.viewHeight(message)).isActive = true
            break
        case .middle:
            self.topAnchor.constraint(equalTo: rootView.layoutMarginsGuide.topAnchor, constant: rootView.frame.size.height / 2 - self.viewHeight(message)).isActive = true
            break
        }
        
        self.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: 10).isActive = true
        self.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -10).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.viewHeight(message)).isActive = true
        
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, multiplier: 0.9).isActive = true
    }
    
    func transfrom(with transform: Transform) {
        switch transform {
        case .show:
         show(hide: false)
         UIView.animate(withDuration: 0.8) { [weak self] in
           self?.alpha = 1
           DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.transfrom(with: .hide)
           }
         }
        case .hide:
        UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
            self?.alpha = 0
            },completion: { _ in
            self.removeFromSuperview()
            })
        }
    }
    
    func show(hide: Bool) {
        self.isHidden = hide
        self.alpha = 0
    }
}
