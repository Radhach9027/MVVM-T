import UIKit

protocol RegisterTableViewCellType {
    var reuseIdentifier: String { get }
    func update(cell: UITableViewCell)
}

protocol RegisterCollectionViewCellType {
    var reuseIdentifier: String { get }
    func update(cell: UICollectionViewCell)
}

protocol RegisterTableView_Header_Footer_Type {
    var reuseIdentifier: String { get }
    func update(header: UIView)
}

protocol ModelUpdateProtocol: class {
    associatedtype ModelData
    func update(modelData: ModelData)
}

protocol TableViewHeaderProtocol: class {
    associatedtype ModelData
    func update(modelData: ModelData)
}

struct ConfigureTableViewHeader<T> where T: TableViewHeaderProtocol, T: UIView {
    let ModelData: T.ModelData
    let reuseIdentifier: String = NSStringFromClass(T.self).components(separatedBy: ".").last!
    func update(header: UIView) {
        if let header = header as? T {
            header.update(modelData: ModelData)
        }
    }
}

struct ConfigureTableViewCustomCell<T> where T: ModelUpdateProtocol, T: UITableViewCell {
    let ModelData: T.ModelData
    let reuseIdentifier: String = NSStringFromClass(T.self).components(separatedBy: ".").last!
    func update(cell: UITableViewCell) {
        if let cell = cell as? T {
            cell.update(modelData: ModelData)
        }
    }
}

struct ConfigureCollectionViewCustomCell<T> where T: ModelUpdateProtocol, T: UICollectionViewCell {
    let ModelData: T.ModelData
    let reuseIdentifier: String = NSStringFromClass(T.self).components(separatedBy: ".").last!
    func update(cell: UICollectionViewCell) {
        if let cell = cell as? T {
            cell.update(modelData: ModelData)
        }
    }
}

extension ConfigureTableViewCustomCell: RegisterTableViewCellType {}
extension ConfigureCollectionViewCustomCell: RegisterCollectionViewCellType {}
extension ConfigureTableViewHeader: RegisterTableView_Header_Footer_Type {}
