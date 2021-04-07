protocol LoginViewModelProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?)-> Void)
    func socialProfileSignIn(signInType: SocialSignInType, delegate: LoginViewModelDelegate)
}

protocol LoginViewModelDelegate: AnyObject {
    func signInSuccess()
    func signInFailure(_ error: String)
}
