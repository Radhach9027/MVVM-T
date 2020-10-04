import Foundation

enum NetworkErrorCode: Error {
    case success
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case authenticationError
    case badRequest
    case outdated
    case unknownError

    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed or Invalid URL"
        case .invalidData: return "Invalid Data."
        case .responseUnsuccessful: return "Response Unsuccessful."
        case .jsonParsingFailure: return "JSON Parsing Failure."
        case .jsonConversionFailure: return "JSON Conversion Failure."
        case .success: return "Success"
        case .authenticationError: return "Authentication Failed."
        case .badRequest: return "Bad Request"
        case .outdated: return "The URL requested is outdated."
        case .unknownError: return "Some Unknow error occured."
        }
    }
    
    static func getHTTStatus(response: HTTPURLResponse) -> NetworkErrorCode {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .authenticationError
        case 501...599:
            return .badRequest
        case 600:
            return .outdated
        default:
            return .unknownError
        }
    }
}

struct NetworkStatus {
    typealias authCompletionHandler = ((_ success: Bool, _ error: NetworkErrorCode?) -> Void)
    
    static func performHttpUrlResponseStatus(_ response: HTTPURLResponse, completionHandler: @escaping authCompletionHandler) {
        let getStatus = NetworkErrorCode.getHTTStatus(response: response)
        switch getStatus {
        case .success:
            completionHandler(true, nil)
        default:
            completionHandler(false, getStatus)
            break
        }
    }
}

