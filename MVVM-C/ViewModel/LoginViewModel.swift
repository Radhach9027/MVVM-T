import Foundation

class LoginViewModel: NetworkClient {
    var session: UrlSessionProtocol
       init(configuration: URLSessionConfiguration) {
           self.session = URLSession(configuration: configuration, delegate: SSLPinning(), delegateQueue: nil)
       }
       
       convenience init() {
           self.init(configuration: .default)
       }
}
