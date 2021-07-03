import UIKit
import GenericCollectionsPackage

class UsersCustomCell: UITableViewCell {
    @IBOutlet fileprivate weak var userImage: UIImageView!
    @IBOutlet fileprivate weak var name: UILabel!
    @IBOutlet fileprivate weak var email: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension UsersCustomCell: ModelUpdateProtocol {
    typealias ModelData = DummyModel 
    
    func update(modelData: DummyModel, indexPath: IndexPath) {
        self.name.text = modelData.title
        self.email.text = modelData.description
        self.userImage.image = modelData.image != nil ? UIImage(named: modelData.image!) : nil
    }
}
