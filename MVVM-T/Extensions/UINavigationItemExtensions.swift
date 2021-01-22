import UIKit

extension UINavigationItem {
    
    func customNavigationTitle(_ align: NSTextAlignment, _ content: String, _ color: UIColor, _ marginLeft: CGFloat, _ font: UIFont) {
        
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = content
        titleLabel.font = font
        titleLabel.textAlignment = align
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleView = titleLabel
        guard let containerView = self.titleView?.superview else { return }
        
        let leftBarItemWidth = self.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + marginLeft),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
}
