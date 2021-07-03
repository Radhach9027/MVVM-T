import Firebase

protocol FireBaseSignInDelegate: AnyObject {
    func signInSuccess()
    func signInFailure(_ error: String)
}

protocol SocialProfilesSignInDelegate: AnyObject {
    func signInSuccess(credential: AuthCredential, signInType: SocialSignInType)
    func signInFailure(_ error: String)
}
