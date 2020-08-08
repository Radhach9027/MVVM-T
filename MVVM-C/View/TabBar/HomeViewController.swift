import UIKit

class HomeViewController: UIViewController {

}

extension HomeViewController {
    @IBAction func homeDetailsButtonPressed(_ sender: UIButton) {
        if let controller: HomeDetailsViewController = Coordinator.route.push(story: .tab, controller: .detail, animated: true, modelTransistion: .coverVertical, modelPresentation: .currentContext).perform() {
            controller.title = "Details"
        }
    }
}
