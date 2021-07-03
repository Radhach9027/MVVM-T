import NetworkClientPackage

class NetworkClient {
    
    #if TEST // use just for mocking purpose when doing unit_testing the app
    
    static var shared: NetworkClient!
    
    override init() {
        super.init()
    }
    
    #else
    
    static let shared = NetworkClient()
    private init() {
        requestDispatcher = NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: NetworkSession().session!)
    }
    
    #endif

    public var requestDispatcher: NetworkRequestDispatcher
    public lazy var networkAction = NetworkAction()
    public lazy var isNetworkReachable = NetworkReachability.shared.isReachable
}

extension NetworkClient: NetworkParserProtocol {}
