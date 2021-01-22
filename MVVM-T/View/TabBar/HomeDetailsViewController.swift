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
        
        let cell = ConfigureTableViewModel<UsersCustomCell>(ModelData: nil)
        let headerView = ConfigureTableViewModel<SectionHeaderView>(ModelData: nil)
        let groupedModel = GroupedGenricSectionModel(sectionItem: 2, rows: [8, 4])

        tableView = GenericTableViewController(grouped: groupedModel, items: [cell], style: .plain, headerView: headerView, rowHeight: .dynamic, headerheight: .dynamic ,cellHandler: { [weak self] (cell, indexPath) in
            print("Cell Rolling")
        }, cellTapHandler:{(cell, indexPath) in
            print("Cell Tapped")
        }, sectionViewHandler: { (view, section) in
            if let headerView = view as? SectionHeaderView {
                headerView.delegate = self
            }
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

