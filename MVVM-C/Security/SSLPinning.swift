import Foundation
import CommonCrypto


class SSLPinning: NSObject, URLSessionDelegate{
    let pinnedCertificateHash = "KjLxfxajzmBH0fTH1/oujb6R5fqBiLxl0zrl2xyFT2E="
    let pinnedPublicKeyHash = "4xVxzbEegwDBoyoGoJlKcwGM7hyquoFg4l+9um5oPOI="
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                DispatchQueue.global().async {
                    SecTrustEvaluateAsyncWithError(serverTrust, DispatchQueue.global()) {
                        trust, result, error in
                        if result {
                            // Public key pinning
                            if let serverPublicKey = SecTrustCopyPublicKey(trust), let serverPublicKeyData: NSData =  SecKeyCopyExternalRepresentation(serverPublicKey, nil) {
                                let keyHash = serverPublicKeyData.description.sha256()
                                if (keyHash == self.pinnedPublicKeyHash) {
                                    completionHandler(.useCredential, URLCredential(trust:serverTrust))
                                    return
                                }
                            }
                            
                            // Certificates pinning
                            /*if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                             let serverCertificateData:NSData = SecCertificateCopyData(serverCertificate)
                             let certHash = serverCertificateData.description.sha256()
                             if (certHash == self.pinnedCertificateHash) {
                             completionHandler(.useCredential, URLCredential(trust:serverTrust))
                             return
                             }
                             }*/
                            
                        } else {
                            print("Trust failed: \(error!.localizedDescription)")
                        }
                    }
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}

extension String {
    func sha256() -> String?{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return nil
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
}
