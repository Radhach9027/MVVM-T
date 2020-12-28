import Foundation
import Firebase
import AuthenticationServices

class AppleSignIn: NSObject {
    
    private var currentController: UIViewController?
    fileprivate var currentNonce: String?
    weak var delegate: SocialSignInDelegate?
    
    init(controller: UIViewController? = nil) {
        print("FacebookSignIn InIt")
        currentController = controller
    }
    
    deinit {
        print("AppleSignIn De-Init")
    }
}

extension AppleSignIn: AppleSignInProtocol {
    
     func signIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        self.currentNonce = randomNonceString()
        request.nonce = sha256(currentNonce!)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleSignIn: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                self.delegate?.signInFailure("Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                self.delegate?.signInFailure("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                self.delegate?.signInFailure("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                if error == nil {
                    self?.delegate?.signInSuccess()
                } else{
                    self?.delegate?.signInFailure(error?.localizedDescription ?? "Something went wrong ApplesignIn authResult")
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.signInFailure("Sign in with Apple errored: \(error)")
    }
}

extension AppleSignIn: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (currentController?.view.window)!
    }
}
