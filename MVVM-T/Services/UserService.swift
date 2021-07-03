import Foundation

protocol UserServiceProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (ServiceResult)-> Void)
}

struct UserService: UserServiceProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (ServiceResult)-> Void) {
        
        NetworkClient.shared.networkAction.fetch(request: requestType, in: NetworkClient.shared.requestDispatcher, completion: { result in
            
            switch result {
                case .noInternet(let message):
                    completion(.error(message?.rawValue))
                    
                case  .json(_, let data):
                    if let data = data {
                        let result = NetworkClient.shared.convertDataToModel(data: data, decodingType: LoginModel.self)
                        switch result {
                            case let .success(model):
                                completion(.success(model))
                            case let .failure(error):
                                completion(.error(error.localizedDescription))
                        }
                    }
                    
                case let .error(error, _):
                    completion(.error(error.debugDescription))
                default:
                    break
            }
        })
    }
}
