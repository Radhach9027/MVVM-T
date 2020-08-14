import Foundation

enum NetworkErrorCode: Error {
    case success
    case accessTokenExpired
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
    
    static func getHTTStatus(response: HTTPURLResponse) -> NetworkErrorCode {
        switch response.statusCode {
        case 200...300:
            return .success
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 403:
            return .accessTokenExpired
        case 404:
            return .notFound
        default:
            return .unknownError
        }
    }
}

struct NetworkError {
    typealias authCompletionHandler = ((_ success: Bool, _ error: NetworkErrorCode?) -> Void)
    
    static func performHttpUrlResponseStatus(_ response: HTTPURLResponse, completionHandler: @escaping authCompletionHandler) {
        let getStatus = NetworkErrorCode.getHTTStatus(response: response)
        switch getStatus {
        case .success:
            completionHandler(true, nil)
        case .accessTokenExpired:
            completionHandler(false, .accessTokenExpired)
        default:
            break
        }
    }
}
