import Foundation

enum NetworkClientError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

protocol NetworkClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkClientError>) -> Void)
    func responseStatus(error: NetworkClientError)
    func networkError()
}

extension NetworkClient {
    typealias JSONTaskCompletionHandler = (Decodable?, NetworkClientError?) -> Void
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
       
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.responseStatus(error: .requestFailed)
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                         completion(genericModel, nil)
                    } catch {
                        self.responseStatus(error: .jsonConversionFailure)
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    self.responseStatus(error: .invalidData)
                    completion(nil, .invalidData)
                }
            } else {
                self.responseStatus(error: .responseUnsuccessful)
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkClientError>) -> Void) {
        if NetworkReachability.shared.isReachable {
            let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
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
    
    func responseStatus(error: NetworkClientError) {
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
