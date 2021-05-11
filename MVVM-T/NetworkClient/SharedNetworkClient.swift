import NetworkClient

class SharedNetworkClient {
    
    #if TEST // use just for mocking purpose when doing unit_testing the app
    
    static var shared: SharedNetworkClient!
    
    override init() {
        super.init()
    }
    
    #else
    
    static let shared = SharedNetworkClient()
    private init() {
        request = NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: NetworkSession().session!)
    }
    
    #endif

    public var request: NetworkRequestDispatcher
    public var networkAction: NetworkAction?
    public var isNetworkReachable = NetworkReachability.shared.isReachable
    
    func injectRequest(request: NetworkRequestProtocol) {
        networkAction = NetworkAction(request: request)
    }
}

extension SharedNetworkClient: NetworkParserProtocol {}
