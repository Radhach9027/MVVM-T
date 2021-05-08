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
        addTableView()
    }
}

extension HomeDetailsViewController {
    
    func addTableView() {
        
        //Prepare Generic custom cell with model
        let tableModel = tableSectionedGroup(DummyModel.users)
        
        tableView = GenericTableViewController(grouped: tableModel, attributes: GenericTableViewAttributes(separatorLine: .singleLine, refreshMessage: .config(messgae: "Loading...", tint: .blue)), cellForRow: { (cell, indexPath) in
            print("Cell Rolling")
        }, didSelectRow: { (cell, indexPath) in
            print("Cell Tapped")
        }, refreshHandler: { (refresh) in
            print("RefreshControl Pulled")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                refresh.endRefreshing()
            print("RefreshControl Ended")
            }
        }, viewForSection: { (header, section) in
            print("Header View")
        }, swipeToDelete: { (tableView, indexPath) in
            print("swipeToDelete Tapped")
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

