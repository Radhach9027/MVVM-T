import Foundation

protocol NetworkEnvironmentProtocol {
    var headers: ReaquestHeaders? { get }
    var baseURL: String { get }
}
