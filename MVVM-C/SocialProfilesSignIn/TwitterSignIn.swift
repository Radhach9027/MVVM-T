import Firebase
import TwitterKit

enum TwitterKeys: String {
    case consumerKey = "dpKWvRRYZXBTdhbRZq3WE1GEK"
    case consumerSecret = "yLNf9OJwbzTrkV1iyXFpSb3AFz44e9hK4VqTkG8zHPsp3yEgUd"
}

struct TwitterSignIn: TwitterLoginProtocol {
    
    private var currentController: UIViewController?
    weak var delegate: SocialSignInDelegate?
    
    init(controller: UIViewController? = nil) {
        print("TwitterSignIn InIt")
        currentController = controller
    }
    
    static func config() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: TwitterKeys.consumerKey.rawValue, consumerSecret: TwitterKeys.consumerSecret.rawValue)
    }
    
    func signIn() {
        
        if TWTRTwitter.sharedInstance().sessionStore.session() == nil {
            TWTRTwitter.sharedInstance().logIn(with: currentController) { (session, error) in
                if let error = error {
                    delegate?.signInFailure(error.localizedDescription)
                } else {
                    guard let token = session?.authToken else {return}
                    guard let secret = session?.authTokenSecret else {return}
                    let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if let error = error {
                            delegate?.signInFailure(error.localizedDescription)
                        } else {
                            delegate?.signInSuccess()
                        }
                    })
                }
            }
        } else {
            delegate?.signInSuccess()
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