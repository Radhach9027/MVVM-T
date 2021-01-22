import UIKit

protocol RegisterTableModelType {
    var reuseIdentifier: String { get }
    func update(cell: UITableViewCell, indexPath: IndexPath)
    func update(view: UIView, section: Int)
}

struct ConfigureTableViewModel<T> where T: ModelUpdateProtocol {
    var ModelData: [[T.ModelData]]?
    let reuseIdentifier: String = NSStringFromClass(T.self).components(separatedBy: ".").last!
    
    func update(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? T, let model = ModelData?[indexPath.section] {
            cell.update(modelData: model.count > 1 ? model[indexPath.row] : model[0], indexPath: indexPath)
        }
    }
    
    func update(view: UIView, section: Int) {
        if let view = view as? T, let model = ModelData?[section].first {
            view.update(modelData: model, indexPath: IndexPath(row: 0, section: section))
        }
    }
}

extension ConfigureTableViewModel: RegisterTableModelType {}


