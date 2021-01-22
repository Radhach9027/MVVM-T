import Foundation
import CommonCrypto


struct SSLPinningKeys {
    static let pinnedCertificateHash = "KjLxfxajzmBH0fTH1/oujb6R5fqBiLxl0zrl2xyFT2E="
    static let pinnedPublicKeyHash = "9596c2427a508c82f95cc8e2af961467fb1077a3a4274fae6f726f9bc2532d85"
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
