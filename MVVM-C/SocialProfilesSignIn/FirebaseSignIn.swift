import Firebase

struct FirebaseSignIn: FirebaseProtocol {
    
    static func signIn(credential: AuthCredential, completion: @escaping (AuthDataResult?, Error?)-> Void) {        
        Auth.auth().signIn(with: credential, completion: completion)
    }

    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    var userExists: Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    var currentUser: Firebase.User? {
        return Auth.auth().currentUser
    }
}
