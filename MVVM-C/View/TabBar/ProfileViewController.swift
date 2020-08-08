import UIKit

class ProfileViewController: UIViewController {

}

extension ProfileViewController {
    @IBAction func logOutBackButtonPressed(_ sender: UIButton) {
        let rootChange = UIStoryboard(name: "Login", bundle: Bundle.main)
        Coordinator.route.switchRootViewController(storyBoard: rootChange, controllerDestination: .launch, animated: true, window: UIWindow.key, modelTransistion: .transitionCrossDissolve).perform()
    }
}
