import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
}

extension SectionHeaderView: ModelUpdateProtocol {
    typealias ModelData = ExpressibleByNilLiteral // pass ur model object when ever required
    func update(modelData: ExpressibleByNilLiteral, indexPath: IndexPath) {}
}

