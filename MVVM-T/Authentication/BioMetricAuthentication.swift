import Foundation
import LocalAuthentication

class BioMetricAuthentication {
    
    typealias authCompletionHandler = ((_ success: Bool, _ error: Error?) -> Void)
    
    private enum BioMetric: String {
        case passCode = "Please use your Passcode"
        case authReason = "Authentication required to access the secure data"
        case error
    }
    
    static func authenticationWithTouchID(completionHandler: @escaping authCompletionHandler) {
        let context = LAContext()
        context.localizedFallbackTitle = BioMetric.passCode.rawValue
        var authorizationError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            let reason = BioMetric.authReason.rawValue
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                if success {
                    DispatchQueue.main.async() {
                        completionHandler(true, nil)
                    }
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {return}
                    DispatchQueue.main.async() {
                        completionHandler(false, error)
                    }
                }
            }
        } else {
            guard let error = authorizationError else {return}
            DispatchQueue.main.async() {
                completionHandler(false, error)
            }
        }
    }
}

