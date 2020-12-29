import Firebase

struct FirebaseSignIn: FirebaseProtocol {
    
    static func signIn(credential: AuthCredential, signInType: SocialSignInType, completion: @escaping (AuthDataResult?, Error?)-> Void) {
        Auth.auth().signIn(with: credential) { (result, error) in
            if error == nil {
                Keychain.storeData(value: signInType, key: FirebaseKeys.signInType.rawValue)
                completion(result, error)
            }
        }
    }

    static func signOut() throws {
        socialLogout()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private static func socialLogout() {
        if let signInData = Keychain<Data>.retriveData(key: FirebaseKeys.signInType.rawValue), let signInType = try? JSONDecoder().decode(SocialSignInType.self, from: signInData) {
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
    
    static var userExists: Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    static var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
}
