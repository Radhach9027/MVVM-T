import Foundation
import Firebase
import AuthenticationServices

class AppleSignIn: NSObject {
    
    private var viewController: UIViewController?
    private var currentNonce: String?
    private weak var delegate: SocialSignInDelegate?
    
    init(viewController: UIViewController? = nil, delegate: SocialSignInDelegate?) {
        print("FacebookSignIn InIt")
        self.viewController = viewController
        self.delegate = delegate
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
            delegate?.signInSuccess(credential: credential, signInType: .apple)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.delegate?.signInFailure("Sign in with Apple errored: \(error)")
    }
}

extension AppleSignIn: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return (self.viewController?.view.window)!
    }
}
