import Foundation
import NetworkClientPackage

enum UserServiceEndPoint {
    case all
    case download(id: String)
}

extension UserServiceEndPoint: NetworkRequestProtocol {
    
    var headers: ReaquestHeaders? { nil }
    var parameters: RequestParameters? { nil }
    var progressHandler: ProgressHandler? { nil }
    
    
    var path: String {
        switch self {
            case .all:
                return "/users"
            case let .download(id):
                return "/wp-content/uploads/2015/12/"+"\(id)"
        }
    }
    
    var method: NetworkRequestMethod {
        switch self {
            case .all, .download(_):
                return .get
        }
    }
    
    var requestType: NetworkRequestType {
        return .data
    }
    
    var responseType: NetworkResponseType {
        switch self {
            case .all:
                return .json
            case .download(_):
                return .file
        }
    }
}
