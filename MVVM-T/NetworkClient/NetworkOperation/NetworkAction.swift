import Foundation

final class NetworkAction: NetworkOperationProtocol {
    
    private var task: NetworkSessionTaskProtocol?
    internal var request: NetworkRequestProtocol
    
    init(request: NetworkRequestProtocol) {
        self.request = request
    }
    
    func cancel() {
        task?.cancel()
    }
    
    func fetch(in requestDispatcher: NetworkRequestDispatchProtocol, completion: @escaping (NetworkOperationResult) -> Void) {
        
        if NetworkReachability.shared.isReachable {
            task = requestDispatcher.fetch(request: request, completion: { result in
                completion(result)
            })
        } else {
            completion(.error(nil, nil, .noInternet))
        }
    }
    
    func killAll(in requestDispatcher: NetworkRequestDispatchProtocol) {
        requestDispatcher.killAllServices()
    }
}
