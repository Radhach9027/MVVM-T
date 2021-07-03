import Foundation

protocol UserServiceProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (ServiceResult)-> Void)
}

struct UserService: UserServiceProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (ServiceResult)-> Void) {
        
        //TODO: Move this line to functional
        SharedNetworkClient.shared.injectRequest(request: requestType)
        SharedNetworkClient.shared.networkAction?.fetch(in: SharedNetworkClient.shared.networkRequest, completion: { result in
            
            switch result {
                case .noInterNet(let message):
                    completion(.error(message?.rawValue))
                case  .json(_, let data):
                    
                    if let data = data {
                        let result = SharedNetworkClient.shared.convertDataToModel(data: data, decodingType: LoginModel.self)
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
