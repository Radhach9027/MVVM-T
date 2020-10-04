import UIKit

class HomeDetailsCustomCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension HomeDetailsCustomCell: ModelUpdateProtocol {
    typealias ModelData = ExpressibleByNilLiteral // pass ur model object when ever required
    func update(modelData: ExpressibleByNilLiteral, indexPath: IndexPath) {}
}
