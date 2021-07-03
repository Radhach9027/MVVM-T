import UIKit
import GenericCollectionsPackage

class HomeDetailsViewController: UIViewController {
    
    private var tableView: GenericTableViewController?
    
    fileprivate lazy var tableSectionedGroup:(_ model: [DummyModel]) -> [Int : [GroupedModel]] =  { (model) in
        //Prepare Generic custom cell with model
        let cell = ConfigureCollectionsModel<UsersCustomCell>(model: model)
        
        //Prepare Generic custom header with model
        let headerView = ConfigureCollectionsModel<SectionHeaderView>()
        
        //Prepare Group model with cells and headers
        let groupedModel = [GroupedModel(section: 0, rows: model.count, customCell: cell, header: headerView)]
        
        //Prepare Section Grouped by grouping with section
        let sectionedGroup = Dictionary(grouping: groupedModel) {$0.section}
        
        return sectionedGroup
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.addTableView()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView = nil
    }
}

extension HomeDetailsViewController {
    
    func addTableView() {
        
        //Prepare Generic custom cell with model
        let tableModel = tableSectionedGroup(DummyModel.users)
        
        tableView = GenericTableViewController(grouped: tableModel, attributes: GenericTableViewAttributes(separatorLine: .singleLine, refreshMessage: .config(messgae: "Hey..was up!", tint: .blue)), cellForRow: { (cell, indexPath) in
            print("Cell rolling")
        }, didSelectRow: { (cell, indexPath) in
            print("Cell tapped")
        }, refreshHandler: { (refresh) in
            print("Refresh control pulled")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                refresh.endRefreshing()
            print("Refresh control ended")
            }
        }, viewForSection: { (header, section) in
            print("Header view actions")
        }, swipeToDelete: { (tableView, indexPath) in
            print("Swipe to delete tapped")
        })
        
        add(tableView!)
        addConstraints(someController: tableView)
    }
}

extension HomeDetailsViewController: SectionHeaderViewDelegate {
    
    func headerTapped() {
        print("Section Tapped")
    }
}

