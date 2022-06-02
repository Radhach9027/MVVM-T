import UIKit

class HomeViewController: UIViewController {}

extension HomeViewController {
    
    private enum Copy {
        static let dummy = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
    }
    
    @IBAction func homeDetailsButtonPressed(_ sender: UIButton) {
        push(type: .detail,
             animated: true,
             hidesTopBar: false,
             hidesBottomBar: false)
    }
    
    @IBAction func alertButtonPressed(_ sender: UIButton) {
        UIWindow.showAlert(message: Copy.dummy)
    }
    
    @IBAction func popUpButtonPressed(_ sender: UIButton) {
        UIWindow.showPopup(message: Copy.dummy,
                           animate: .affineIn)
    }
    
    @IBAction func slideViewButtonPressed(_ sender: UIButton) {
        UIWindow.showSlideView(message: Copy.dummy,
                               position: .top)
    }
    
    @IBAction func loadingButtonPressed(_ sender: UIButton) {
        UIWindow.showLoading(steps: .start(animate: true))
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            UIWindow.showLoading(steps: .success(animate: true,
                                                 color: .systemGreen))
        }
    }
}
