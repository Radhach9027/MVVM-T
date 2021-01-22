import Foundation

protocol NetworkSessionTaskProtocol: class {
    func cancel()
    func suspend()
    func resume()
}

extension URLSessionTask: NetworkSessionTaskProtocol {}
