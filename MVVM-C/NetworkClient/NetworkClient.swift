import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

enum NetworkRequestType {
    case dataTask
    case uploadTask
    case downloadTask
}

extension NetworkClient {
    typealias JSONTaskCompletionHandler = (Decodable?, NetworkErrorCode?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, networkType: NetworkRequestType,  decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            NetworkStatus.performHttpUrlResponseStatus(httpResponse) { (success, error) in
                if success && error == nil {
                    if let data = data {
                        do {
                            let genericModel = try JSONDecoder().decode(decodingType, from: data)
                            completion(genericModel, nil)
                        } catch {
                            completion(nil, .jsonConversionFailure)
                        }
                    } else {
                        completion(nil, .invalidData)
                    }
                } else if (!success && error == NetworkErrorCode.authenticationError) {
                    
                } else {
                    
                }
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, networkType: NetworkRequestType,  decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkErrorCode>) -> Void) {
        if NetworkReachability.shared.isReachable {
            let task = decodingTask(with: request, networkType: networkType, decodingType: T.self) { (json , error) in
                DispatchQueue.main.async {
                    guard let json = json else {
                        if let error = error {
                            self.responseStatus(error: error)
                            completion(Result.failure(error))
                        } else {
                            self.responseStatus(error: .invalidData)
                            completion(Result.failure(.invalidData))
                        }
                        return
                    }
                    if let value = decode(json) {
                        completion(.success(value))
                    } else {
                        self.responseStatus(error: .jsonParsingFailure)
                        completion(.failure(.jsonParsingFailure))
                    }
                }
            }
            task.resume()
        } else {
            self.networkError()
        }
    }
    
    func killAllServices() {
        self.session.getAllTasks { (tasks) in
            tasks.first(where: {$0.state == .running})?.cancel()
        }
    }
    
    func responseStatus(error: NetworkErrorCode) {
        DispatchQueue.main.async {
            CustomPopup().present(message: error.localizedDescription, animate: .affineIn)
        }
    }
    
    func networkError(){
        DispatchQueue.main.async {
            _ = AnimatedView(message: .noInternet, postion: .top, bgColor: .systemRed)
        }
    }
}
