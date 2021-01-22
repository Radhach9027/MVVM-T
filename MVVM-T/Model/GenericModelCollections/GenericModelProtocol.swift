import UIKit

protocol ModelUpdateProtocol: class {
    associatedtype ModelData
    func update(modelData: ModelData, indexPath: IndexPath)
}

