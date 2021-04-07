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
        do {
            try FirebaseSignIn.signOut()
            storySwitch(story: .login, destination: .launch, animated: true, hidesTopBar: false, hidesBottomBar: false)
        } catch let signOutError as NSError {
            presentAlert("Error signing out from FirebaseSignIn: %@ \(signOutError)")
        }
    }
}

