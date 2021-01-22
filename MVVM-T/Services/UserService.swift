import Foundation

protocol UserServiceProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
    func dowloadFile(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
}

class UserService {
    
    @Inject private var requestDispatcher: NetworkRequestDispatcher
    
    deinit {
        print("UserService de-init")
    }
}

extension UserService: UserServiceProtocol, NetworkParserProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void) {
        
        let networkAction = NetworkAction(request: requestType)
        
        networkAction.fetch(in: requestDispatcher) { [weak self] result in
            switch result {
                case  .json(_, let data):
                    
                    if let data = data {
                        
                        let result = self?.convertDataToModel(data: data, decodingType: LoginModel.self)
                        
                        switch result {
                            case let .success(model):
                                completion(true, nil, model)
                            case let .failure(error):
                                completion(false, error, nil)
                            case .none:
                                break
                        }
                    }
                case let .error(error, _, noNetwork):
                    completion(false, error, noNetwork)
                default:
                    break
            }
        }
    }
    
    func dowloadFile(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void) {
        let networkAction = NetworkAction(request: requestType)
        
        networkAction.fetch(in: requestDispatcher) { result in
            
            switch result {
                case let .file(file, response):
                    print("File = \(String(describing: file)), response = \(String(describing: response))")
                default:
                    break
            }
        }
    }
}
