import Firebase
import TwitterKit

struct TwitterSignIn: TwitterSignInProtocol {
    
    private var viewController: UIViewController?
    weak var delegate: SocialSignInDelegate?
    
    init(viewController: UIViewController? = nil) {
        print("TwitterSignIn InIt")
        self.viewController = viewController
    }
    
    static func config() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: TwitterKeys.consumerKey.rawValue, consumerSecret: TwitterKeys.consumerSecret.rawValue)
    }
    
    func signIn() {
        
        if TWTRTwitter.sharedInstance().sessionStore.session() == nil {
            TWTRTwitter.sharedInstance().logIn(with: self.viewController) { (session, error) in
                if let error = error {
                    delegate?.signInFailure(error.localizedDescription)
                } else {
                    guard let token = session?.authToken, let secret = session?.authTokenSecret else {
                        delegate?.signInFailure("Failed to retrive Twitter session tokens")
                        return
                    }
                    let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
                    delegate?.signInSuccess(credential: credential, signInType: .twitter)
                }
            }
        }
    }
    
    static func signOut() {
        let sessionStore = TWTRTwitter.sharedInstance().sessionStore
        if let userID = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userID)
        }
    }
    
    @discardableResult
    static func handleUrl(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
}
