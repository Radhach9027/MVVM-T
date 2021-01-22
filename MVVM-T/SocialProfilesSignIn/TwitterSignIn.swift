import Firebase
import TwitterKit

struct TwitterSignIn: TwitterSignInProtocol {
    
    private var viewController: UIViewController?
    private weak var delegate: SocialSignInDelegate?
    
    init(viewController: UIViewController? = nil, delegate: SocialSignInDelegate?) {
        print("TwitterSignIn InIt")
        self.viewController = viewController
        self.delegate = delegate
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
            
        } else {
            
            guard let session = TWTRTwitter.sharedInstance().sessionStore.session() else {
                delegate?.signInFailure("Failed to retrive Twitter session tokens")
                return
            }
            let credential = TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret)
            delegate?.signInSuccess(credential: credential, signInType: .twitter)
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
