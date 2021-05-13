import UIKit

class HomeViewController: UIViewController {}

extension HomeViewController: TravellerProtocol {
    @IBAction func homeDetailsButtonPressed(_ sender: UIButton) {
        push(type: .detail, animated: true, hidesTopBar: false, hidesBottomBar: false)
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        ResuableComponents.shared.presentAlert(title: "Hey Alert..!", message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", controller: self)
    }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        ResuableComponents.shared.presentCustomPopup(message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", animate: .affineIn)
    }
    
    @IBAction func slideViewButtonPressed(_ sender: UIButton) {
        ResuableComponents.shared.slideView(messgae: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", controller: self)
    }
    
    @IBAction func loadingButtonPressed(_ sender: UIButton) {
        ResuableComponents.shared.presentLoadingIndicator(steps: .start(animate: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            ResuableComponents.shared.presentLoadingIndicator(steps: .success(animate: true, color: .systemGreen))
        }
    }
}
