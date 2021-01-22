import UIKit

class HomeViewController: UIViewController {

}

extension HomeViewController {
    @IBAction func homeDetailsButtonPressed(_ sender: UIButton) {
        if let controller: HomeDetailsViewController = Traveller.route.push(story: .tab, controller: .detail, animated: true, hidesBottomBar: true, modelTransistion: .coverVertical, modelPresentation: .currentContext).perform() {
            controller.title = "Details"
        }
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        Alert.presentAlert(withTitle: "Hey Alert..!", message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", actionParameters: [AlertParameters(title: "Action", action: { (action) in
            print("Perform your action")
        }, preferredAction: true, actionStyle: .destructive)], controller: self, style: .alert)
    }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        CustomPopup.shared.present(message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", animate: .affineIn)
    }
    
    @IBAction func slideViewButtonPressed(_ sender: UIButton) {
        AnimatedView.shared.present(message: .internet, postion: .top, bgColor: .indigoColor())
    }
    
    @IBAction func loadingButtonPressed(_ sender: UIButton) {
        LoadingIndicator.shared.loading(step: .start(animate: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            LoadingIndicator.shared.loading(step: .success(animate: true))
        }
    }
}