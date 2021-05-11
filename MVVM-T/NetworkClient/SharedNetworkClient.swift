import NetworkClient

class SharedNetworkClient {
    
    static let shared = SharedNetworkClient()

    public var request: NetworkRequestDispatcher
    public var networkAction: NetworkAction?

    private init() {
        request = NetworkRequestDispatcher(environment: NetworkEnvironment.dev, networkSession: NetworkSession().session!)
    }
    
    func injectRequest(request: NetworkRequestProtocol) {
        networkAction = NetworkAction(request: request)
    }
}

extension SharedNetworkClient: NetworkParserProtocol {}
