import UIKit

class HomeDetailsViewController: UIViewController {
    private var tableView: GenericTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
}

extension HomeDetailsViewController {
    
    func addTableView() {
        
        let groupedModel = GroupedGenricSectionModel(sectionItem: 2, rows: [5])
        let cell = ConfigureTableViewModel<UsersCustomCell>(ModelData: nil)
        let headerView = ConfigureTableViewModel<SectionHeaderView>(ModelData: nil)

        tableView = GenericTableViewController(grouped: groupedModel, items: [cell], style: .grouped, headerView: headerView, headerheight: .require(height: 74) ,cellHandler: { (cell, indexPath) in
            }, cellTapHandler:{(cell, indexPath) in
        }, sectionViewHandler: { (view, section) in
            
        })
        add(tableView!)
        addConstraints(someController: tableView)
    }
}

