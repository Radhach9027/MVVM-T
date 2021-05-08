import UIKit

class ProfileViewController: UIViewController, BarButtonItemConfiguration {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonItem(ofType: .notification(.right), imageType: .notification)
    }
}

extension ProfileViewController: BarButtonActions, TravellerProtocol {
    
    func showNotification(_ sender: AnyObject) {
        present(type: .detail, animated: true, hidesTopBar: false, hidesBottomBar: false)
    }
    
    @IBAction func logOutBackButtonPressed(_ sender: UIButton) {
        if let error = AutoLogin().logOut() {
            presentAlert(error)
        }
    }
}

