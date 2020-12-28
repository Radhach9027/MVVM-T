import Foundation
import Firebase

struct TwitterLogin: TwitterLoginProtocol {
    weak var delegate: SocialSignInDelegate?
    
     func signIn() {
        var provider = OAuthProvider(providerID: "twitter.com")
        provider.customParameters = ["lang": "fr"]
        provider.getCredentialWith(nil) { credential, error in
            if let errorMsg = error {
                delegate?.signInFailure(errorMsg.localizedDescription)
                return
            }
            
            if let credential = credential{
                Auth.auth().signIn(with: credential) { authResult, error in
                    if error != nil {
                        // Handle error.
                    }
                    // User is signed in.
                    // IdP data available in authResult.additionalUserInfo.profile.
                    // Twitter OAuth access token can also be retrieved by:
                    // authResult.credential.accessToken
                    // Twitter OAuth ID token can be retrieved by calling:
                    // authResult.credential.idToken
                    // Twitter OAuth secret can be retrieved by calling:
                    // authResult.credential.secret
                }
            }
        }
    }
}
