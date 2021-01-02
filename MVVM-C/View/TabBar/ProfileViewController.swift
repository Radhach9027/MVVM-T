import UIKit

class ProfileViewController: UIViewController, BarButtonItemConfiguration {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButtonItem(ofType: .notification(.right), imageType: .notification)
    }
}

extension ProfileViewController: BarButtonActions {
    func showNotification(_ sender: AnyObject) {
        Traveller.route.present(story: .tab, controller: .detail, animated: true, modelTransistion: .crossDissolve, modelPresentation: .fullScreen).perform { (controller) in
            controller.title = "Settings"
        }
    }
}

extension ProfileViewController: StorySwitchProtocol {
    
    @IBAction func logOutBackButtonPressed(_ sender: UIButton) {
        do {
            try FirebaseSignIn.signOut()
            switchToLaunch()
        } catch let signOutError as NSError {
            presentAlert("Error signing out from FirebaseSignIn: %@ \(signOutError)")
        }
    }
}
