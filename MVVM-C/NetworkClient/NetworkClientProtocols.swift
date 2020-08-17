import UIKit

protocol UrlSessionProtocol: class {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func uploadTask(with request: URLRequest, fromFile fileURL: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
    func downloadTask(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void)
    func invalidateAndCancel()
}

extension URLSession: UrlSessionProtocol {}


protocol NetworkClient {
    var session: UrlSessionProtocol { get }
    func fetch<T: Decodable>(with request: URLRequest, networkType: NetworkRequestType,  decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkErrorCode>) -> Void)
    func responseStatus(error: NetworkErrorCode)
    func networkError()
    func killAllServices()
}


protocol RequestProvidingProtocol {
    var urlRequest: URLRequest { get }
}
