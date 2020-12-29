import Firebase

enum SocialSignInType: String, Codable {
    case google
    case apple
    case facebook
    case twitter
    case microsoft
    case github
}

enum FirebaseKeys: String {
    case signInType
}

struct FirebaseSignIn: FirebaseProtocol {
    
    static func signIn(credential: AuthCredential, signInType: SocialSignInType, completion: @escaping (AuthDataResult?, Error?)-> Void) {
        Keychain.storeData(value: signInType, key: FirebaseKeys.signInType.rawValue)
        Auth.auth().signIn(with: credential, completion: completion)
    }

    static func signOut() {
        socialLogout()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private static func socialLogout() {
        if let signInType = Keychain<SocialSignInType>.retriveData(key: FirebaseKeys.signInType.rawValue) {
            switch signInType {
                case .google:
                    GoogleSingIn.signOut()
                case .facebook:
                    FacebookSignIn.signOut()
                case .twitter:
                    TwitterSignIn.signOut()
                default:
                    break
            }
        }
    }
    
    var userExists: Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
}
