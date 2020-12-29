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
                self.delegate?.signInFailure(AppleSignInMessages.invalid.rawValue)
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                self.delegate?.signInFailure(AppleSignInMessages.tokenNotFound.rawValue)
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                self.delegate?.signInFailure(" \(AppleSignInMessages.notSerialized.rawValue) \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            FirebaseSignIn.signIn(credential: credential, signInType: .apple) { [weak self] (authResult, error) in
                if error == nil {
                    self?.delegate?.signInSuccess()
                } else{
                    self?.delegate?.signInFailure(error?.localizedDescription ?? AppleSignInMessages.somethingWrong.rawValue)
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
