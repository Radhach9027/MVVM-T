import UIKit

enum CustomPopupAnimateOptions {
    case affineIn
    case crossDisolve
    case affineOut
    case bounce
}

class CustomPopup: UIView, Nib {
    @IBOutlet weak var customPopView: CustomView!
    @IBOutlet weak var headerBgView: CustomImageView!
    @IBOutlet weak var headerCircularView: CustomView!
    @IBOutlet weak var headerCircularImageView: CustomImageView!
    @IBOutlet weak var dismissButton: CustomButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!

    private var currentState: CustomPopupAnimateOptions = .affineIn
    
    init() {
        super.init(frame: .zero)
        loadNibFile()
        headerBgView.clipsToBounds = true
        headerBgView.layer.cornerRadius = 10
        headerBgView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibFile() {
        registerNib()
    }
}

extension CustomPopup {
    func present(message: String, animate: CustomPopupAnimateOptions) {
        self.messageLabel.text = message
        self.currentState = animate
        switch animate {
        case .affineIn:
            transfromToAffine(view: self.customPopView)
        case .crossDisolve:
            transfromToCrossDisolve(view: self.customPopView)
        case .affineOut:
            transfromToAffineOut(view: self.customPopView)
        case .bounce:
            transformToBounce(view: self.customPopView)
        }
    }
}

private extension CustomPopup {
    func transfromToAffine(view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.transform = CGAffineTransform(scaleX: 0, y: 0)
            UIView.animate(withDuration: 0.5, animations: {
                view.alpha = 1
                view.transform = .identity
            })
        }
    }
    
    func transfromToAffineOut(view: UIView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
             UIView.animate(withDuration: 0.5, animations: {
                 view.transform = .identity
             })
         }
    }
    
    func transfromToCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration: 1.5, options: .transitionCrossDissolve, animations: {
            view.alpha = 1
        }, completion: nil)
    }
    
    func transformToBounce(view: UIView) {
        UIView.animate(withDuration: 1.5,
                       delay: 0.5,
                       usingSpringWithDamping: 2.0,
        initialSpringVelocity: 2.0,
        options: [],
        animations: {
            view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            view.alpha = 1
        }, completion: {
            (value: Bool) in
            UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
                view.transform = .identity
            }
        )
      })
    }
    
    func dismissTransfromAffineOut(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            view.alpha = 0.5
        }) { (true) in
            view.alpha = 0
            self.removeFromSuperview()
        }
    }
    
    func dismissTransfromAffine(view: UIView) {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.2, options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            view.alpha = 0.5
        }) { (true) in
            view.alpha = 0
            self.removeFromSuperview()
        }
    }
    
    func dismissCrossDisolve(view: UIView) {
        UIView.transition(with: view, duration:1.5, options: .transitionCrossDissolve, animations: {
            view.alpha = 0
        }){ (true) in
            self.removeFromSuperview()
        }
    }
    
    func dismissTransformBounce(view: UIView) {
          UIView.animate(withDuration: 1.5,
                         delay: 0.5,
                         usingSpringWithDamping: 2.0,
          initialSpringVelocity: 2.0,
          options: [],
          animations: {
            view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            view.alpha = 1
          }, completion: {
              (value: Bool) in
            view.transform = .identity
            UIView.transition(with: view, duration: 0.2, options: .curveEaseOut, animations: {
            view.alpha = 0
            self.removeFromSuperview()
            }
          )
        })
    }
    
    func dismiss(view: UIView) {
        switch currentState {
        case .affineIn:
            dismissTransfromAffine(view: view)
        case .crossDisolve:
            dismissCrossDisolve(view: view)
        case .affineOut:
            dismissTransfromAffineOut(view: view)
        case .bounce:
            dismissTransformBounce(view: view)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(view: self.customPopView)
    }
}

