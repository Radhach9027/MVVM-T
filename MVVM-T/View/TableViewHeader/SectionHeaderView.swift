import UIKit
import GenericCollectionsPackage

protocol SectionHeaderViewDelegate: AnyObject {
    func headerTapped()
}

class SectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: SectionHeaderViewDelegate?
}

extension SectionHeaderView {
    
    @IBAction func headerViewTapped(_ sender: UIButton) {
        delegate?.headerTapped()
    }
}

extension SectionHeaderView: ModelUpdateProtocol {
    typealias ModelData = ExpressibleByNilLiteral // pass ur model object when ever required
    func update(modelData: ExpressibleByNilLiteral,
                indexPath: IndexPath) {}
}

