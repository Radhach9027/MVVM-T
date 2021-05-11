import Foundation
import DependencyContainer

protocol UserServiceProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
    func dowloadFile(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
}

class UserService {
    init() { print("UserService init") }
    deinit { print("UserService de-init") }
}

extension UserService: UserServiceProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void) {
        
        SharedNetworkClient.shared.injectRequest(request: requestType)
        
        SharedNetworkClient.shared.networkAction?.fetch(in: SharedNetworkClient.shared.request, completion: { result in
            
            switch result {
                case  .json(_, let data):
                    
                    if let data = data {
                        let result = SharedNetworkClient.shared.convertDataToModel(data: data, decodingType: LoginModel.self)
                        switch result {
                            case let .success(model):
                                completion(true, nil, model)
                            case let .failure(error):
                                completion(false, error, nil)
                        }
                    }
                case let .error(error, _, noNetwork):
                    completion(false, error, noNetwork)
                default:
                    break
            }
        })
    }
    
    func dowloadFile(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?) -> Void) {
        
        SharedNetworkClient.shared.injectRequest(request: requestType)
        
        SharedNetworkClient.shared.networkAction?.fetch(in: SharedNetworkClient.shared.request, completion: { result in
            switch result {
                case let .file(file, response):
                    print("File = \(String(describing: file)), response = \(String(describing: response))")
                default:
                    break
            }
        })
    }
    
}
