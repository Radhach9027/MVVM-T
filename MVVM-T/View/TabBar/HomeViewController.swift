import UIKit

class HomeViewController: UIViewController {}

extension HomeViewController {
    
    @IBAction func homeDetailsButtonPressed(_ sender: UIButton) {
        push(type: .detail, animated: true, hidesTopBar: false, hidesBottomBar: false)
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        UIWindow.showAlert(message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
    }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        UIWindow.showPopup(message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", animate: .affineIn)
    }
    
    @IBAction func slideViewButtonPressed(_ sender: UIButton) {
        UIWindow.showSlideView(message: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", position: .top)
    }
    
    @IBAction func loadingButtonPressed(_ sender: UIButton) {
        UIWindow.showLoading(steps: .start(animate: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            UIWindow.showLoading(steps: .success(animate: true, color: .systemGreen))
        }
    }
}
