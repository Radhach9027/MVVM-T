enum HTTPMethod: String {
    case put = "PUT"
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case head = "HEAD"
    case patch = "PATCH"
}

enum HTTPHeaderType: String {
    case json = "application/json"
    case headerAccept = "Accept"
    case headerContentType = "Content-Type"
    case auth = "Authorization"
    case formData
    
    func convert(boundry: String) -> String? {
        switch self {
        case .formData:
            return "multipart/form-data; boundary=\(boundry)"
        default:
            break
        }
        return nil
    }
}

