import Foundation

protocol UserServiceProtocol {
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
    func dowloadFile(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void)
    func dispose()
}

class UserService {
    
    private var requestDispatcher: NetworkRequestDispatcher?
    private var session: NetworkSessionProtocol?

    init(environment: NetworkEnvironment = .dev) {
        print("UserService init")
        self.session = NetworkSession(config: URLSession.configuration(30, nil), queue: URLSession.queue(1, .userInitiated)).session
        guard let session = self.session else { fatalError("Couldn't inject NetworkSession from UserService") }
        requestDispatcher = NetworkRequestDispatcher(environment: environment, networkSession: session)
    }
    
    deinit {
        print("UserService de-init")
        dispose()
    }
}

extension UserService: UserServiceProtocol, NetworkParserProtocol {
    
    func fetchUser(requestType: UserServiceEndPoint, completion: @escaping (Bool, Error?, Any?)-> Void) {
        let networkAction = NetworkAction(request: requestType)
        guard let dispatcher = requestDispatcher else { fatalError("Couldn't dispatch fetchUser") }
        
        networkAction.fetch(in: dispatcher) { [weak self] result in
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
        guard let dispatcher = requestDispatcher else { fatalError("Couldn't dispatch dowloadFile") }
        
        networkAction.fetch(in: dispatcher) { result in
            
            switch result {
                case let .file(file, response):
                    print("File = \(String(describing: file)), response = \(String(describing: response))")
                default:
                    break
            }
        }
    }
    
    func dispose() {
        self.requestDispatcher = nil
        self.session = nil
    }
}
