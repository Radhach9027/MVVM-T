import UIKit

class UsersCustomCell: UITableViewCell {
    @IBOutlet fileprivate weak var userImage: UIImageView!
    @IBOutlet fileprivate weak var name: UILabel!
    @IBOutlet fileprivate weak var email: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension UsersCustomCell: ModelUpdateProtocol {
    typealias ModelData = ExpressibleByNilLiteral // pass ur model object when ever required
    func update(modelData: ExpressibleByNilLiteral, indexPath: IndexPath) {}
}
