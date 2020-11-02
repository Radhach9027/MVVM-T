import UIKit

protocol PopupListDelegate: class {
    func didSelectedOption(type: PopupListTypes, value: String)
}

class PopupList: UIView, Nib {
    
    private static var sharedInstance: PopupList?
    class var shared : PopupList {
        
        guard let instance = self.sharedInstance else {
            let strongInstance = PopupList()
            self.sharedInstance = strongInstance
            return strongInstance
        }
        return instance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
    
    private init() {
        super.init(frame: .zero)
        loadNibFile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibFile() {
        registerNib()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.searchBar[keyPath: \.searchTextField].font = .lightFont()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    weak var delegate: PopupListDelegate?
    private var currentState: CustomPopupAnimateOptions = .affineIn
    private var currentType: PopupListTypes = .City
    private var jsonArray = [String]()
}

extension PopupList {
    
    func present(type: PopupListTypes, animate: CustomPopupAnimateOptions) {
        
        self.currentState = animate
        self.currentType = type
        self.titleLabel.text = "Select \(type.rawValue)"
        self.searchBar.placeholder = "Search for \(type.rawValue)"
        
        switch type {
        case .City:
            jsonArray = ["Hyderabad", "Banglore", "Alleppey", "Vizag", "Chennai"]
        case .State:
            jsonArray = ["Telangana", "Karnataka", "Kerala", "Andhra pradesh", "Tamilnadu"]
        }
        
        if let currentController = UIWindow.getTopViewController() {
            currentController.view.addSubview(self)
            addConstraints(present: currentController)
        }
    }
    
    func addConstraints(present: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: present.view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: present.view.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: present.view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: present.view.bottomAnchor).isActive = true
    }
}


extension PopupList: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension PopupList: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.textLabel?.text = jsonArray[indexPath.row]
            cell.textLabel?.textColor = .detailContentColor()
            cell.textLabel?.font = .regularLightFont()
            return cell
        }
        return UITableViewCell()
    }
}


extension PopupList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let value = jsonArray[indexPath.row]
        delegate?.didSelectedOption(type: self.currentType, value: value)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}


extension PopupList {
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        PopupList.destroy()
        self.removeFromSuperview()
    }
}
