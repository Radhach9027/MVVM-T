import Firebase

protocol FireBaseSignInDelegate: class {
    func signInSuccess()
    func signInFailure(_ error: String)
}

protocol SocialSignInDelegate: class {
    func signInSuccess(credential: AuthCredential, signInType: SocialSignInType)
    func signInFailure(_ error: String)
}
