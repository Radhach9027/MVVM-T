import UIKit

enum LC_LoadingSteps {
    case start(animate: Bool)
    case end
    case success(animate: Bool)
    case failure(animate: Bool)
}

class LoadingIndicator: UIView, Nib {
    static let shared = LoadingIndicator()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: CustomView!
    @IBOutlet weak var statusImageView: UIImageView!
    
    private var status: Bool = false
    private var title: String?
    private var duration: Double = 0.25

    
   private init(title: String? = "Loading...") {
        self.title = title
        super.init(frame: .zero)
        loadNibFile()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibFile() {
       registerNib()
    }
    
    func loading(step: LC_LoadingSteps) {
        switch step {
        case .start(let animated):
        startAnimating(animated: animated)
        case .end:
        stopAnimating()
        case .success(let animated):
        self.status = true
        self.statusImageView.image = UIImage(named: "check")
        success(animated: animated)
        case .failure(let animated):
        self.status = true
        self.statusImageView.image = UIImage(named: "close")
        success(animated: animated)
        print("failure")
      }
    }
}


private extension LoadingIndicator {
    func startAnimating(animated: Bool) {
        guard let title = self.title else {return}
        if !status {
            animate(show: true)
            if  animated {
                self.titleLabel.animate(newText: title, characterDelay: duration)
                self.perform(#selector(runTimedCode), with: self, afterDelay: 3, inModes: [.common])
            } else {
                self.titleLabel.text = title
            }
        }
    }
    
    func stopAnimating() {
        self.titleLabel.text = ""
        self.spinner.stopAnimating()
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            self?.alpha = 0
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    func success(animated: Bool) {
        animate(show: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.34) { [weak self] in
            UIView.animate(withDuration: 0.6, animations: { [weak self] in
                self?.loadingView.backgroundColor = UIColor(displayP3Red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
                self?.statusImageView.alpha = 0.5
            }) { (true) in
                self?.statusImageView.alpha = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.stopAnimating()
                }
            }
        }
    }
    
    func animate(show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.spinner.startAnimating()
                self.spinner.isHidden = false
                self.titleLabel.isHidden = false
            }else {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.titleLabel.isHidden = true
            }
        }
    }
    
    @objc func runTimedCode() {
        self.startAnimating(animated: true)
    }
}
