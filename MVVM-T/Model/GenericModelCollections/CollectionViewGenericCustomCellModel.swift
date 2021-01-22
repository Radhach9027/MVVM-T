import UIKit

protocol RegisterCollectionViewCellType {
    var reuseIdentifier: String { get }
    func update(cell: UICollectionViewCell,  indexPath: IndexPath)
}

struct ConfigureCollectionViewCustomCell<T> where T: ModelUpdateProtocol, T: UICollectionViewCell {
    let ModelData: T.ModelData
    let reuseIdentifier: String = NSStringFromClass(T.self).components(separatedBy: ".").last!
    func update(cell: UICollectionViewCell, indexPath: IndexPath) {
        if let cell = cell as? T {
            cell.update(modelData: ModelData, indexPath: indexPath)
        }
    }
}

extension ConfigureCollectionViewCustomCell: RegisterCollectionViewCellType {}

