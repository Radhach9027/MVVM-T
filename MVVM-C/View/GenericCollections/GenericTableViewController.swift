//Copyright © 2020 Radhachandan Chilamkurthy. All rights reserved.

import UIKit

private enum TableView_Row_HeaderFooter_Heights: CGFloat {
    case row = 44.0
    case estimated_section_footer = 25.0
    case section_footer_none = 0.0
}

enum Height {
    case require(height: CGFloat)
    case dynamic
}

struct GroupedSection<SectionItem : Hashable, RowItem> {
    var sectionItem : SectionItem
    var rows : [RowItem]
    static func group(headlines : [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: headlines, by: criteria)
        return groups.map(GroupedSection.init(sectionItem:rows:))
    }
}

final class GenericTableViewController: UITableViewController {
    var items: [RegisterTableViewCellType]
    var sections: Int = 0
    var _sections = [GroupedSection<Int, RegisterTableViewCellType>]()
    private var headerHeight: Height = .dynamic
    private var footerHeight: Height = .dynamic
    private var headerView: RegisterTableView_Header_Footer_Type?
    private var footerView: RegisterTableView_Header_Footer_Type?
    private var cellSelection: UITableViewCell.SelectionStyle = .none
    private var cellHandler: (UITableViewCell, IndexPath) -> Void
    private var cellTapHandler: (RegisterTableViewCellType, IndexPath) -> Void
    private var refreshHandler:((UIRefreshControl) -> Void)?
    internal lazy var refresh: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action:#selector(self.handleRefresh(_:)),for: UIControl.Event.valueChanged)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching data...")
    refreshControl.tintColor = .gray
    return refreshControl
    }()
    
    init(_sections:[GroupedSection<Int, RegisterTableViewCellType>]? = nil, items: [RegisterTableViewCellType], sections: Int , cellSelection: UITableViewCell.SelectionStyle = .none, style: UITableView.Style = .plain, separatorLine: UITableViewCell.SeparatorStyle = .singleLine, headerView: RegisterTableView_Header_Footer_Type? = nil, footerView: RegisterTableView_Header_Footer_Type? = nil, height: Height = .dynamic, footerHeight: Height = .dynamic, headerheight: Height = .dynamic,  refresh: Bool = false, cellHandler: @escaping (UITableViewCell, IndexPath) -> Void, cellTapHandler: @escaping (RegisterTableViewCellType, IndexPath) -> Void, refreshHandler:((UIRefreshControl)-> Void)? = nil) {
        if let sectionGrouped = _sections {
            self._sections = sectionGrouped
        }
        self.items = items
        self.sections = sections
        self.cellHandler = cellHandler
        self.cellTapHandler = cellTapHandler
        self.cellSelection = cellSelection
        self.refreshHandler = refreshHandler
        self.headerHeight = headerheight
        self.footerHeight = footerHeight
        super.init(style: style)
        
        if style == .insetGrouped {
            self.tableView.contentInset = UIEdgeInsets(top: -20, left:0, bottom:0, right: 0)
        }
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = separatorLine
        self.rowHeight(height: height)
        self.headerView = headerView
        self.footerView = footerView
        registerCell()
        register_Header_Footer()
        addRefreshControl(isRefresh: refresh)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(" GenericTableViewController de-init")
    }
}

private extension GenericTableViewController {
    
    func registerCell() {
        Set(items.compactMap({$0.reuseIdentifier})).forEach({
            tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        })
    }
    
    func register_Header_Footer() {
        if let header = self.headerView {
            tableView.register(UINib(nibName: header.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: header.reuseIdentifier)
        }
        if let footer = self.footerView {
            tableView.register(UINib(nibName: footer.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: footer.reuseIdentifier)
        }
    }
    
    func cleanUp(items: [RegisterTableViewCellType]) {
        if items.count > 0 {
            self.items.removeAll()
            self.items.append(contentsOf: items)
        }
    }
    
    func rowHeight(height: Height) {
        switch height {
        case .dynamic:
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.estimatedRowHeight = TableView_Row_HeaderFooter_Heights.row.rawValue
        case .require(let height):
            self.tableView.rowHeight = height
            self.tableView.estimatedRowHeight = height
        }
    }
    
    func addRefreshControl(isRefresh: Bool) {
        if isRefresh {
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refresh
            } else {
                tableView.addSubview(refresh)
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if let refresh = self.refreshHandler {
            refresh(refreshControl)
        }
    }
}


extension GenericTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self._sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self._sections[section]
        return section.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configureCustomCell = items[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: configureCustomCell.reuseIdentifier, for: indexPath)
        configureCustomCell.update(cell: cell)
        cell.selectionStyle = self.cellSelection
        cellHandler(cell, indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        cellTapHandler(item, indexPath)
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.headerView, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.reuseIdentifier) else {return nil}
        header.update(header: view)
        return view
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        guard let footer = self.footerView, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.reuseIdentifier) else {return nil}
        footer.update(header: view)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.headerView else { return TableView_Row_HeaderFooter_Heights.section_footer_none.rawValue}
        switch self.headerHeight {
        case .dynamic:
            return UITableView.automaticDimension
        case let.require(height):
            return height
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let _ = self.footerView else { return TableView_Row_HeaderFooter_Heights.section_footer_none.rawValue}
        switch self.footerHeight {
        case .dynamic:
            return UITableView.automaticDimension
        case let.require(height):
            return height
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.headerView else { return TableView_Row_HeaderFooter_Heights.section_footer_none.rawValue}
        switch self.headerHeight {
        case .dynamic:
            return TableView_Row_HeaderFooter_Heights.estimated_section_footer.rawValue
        case let.require(height):
            return height
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard let _ = self.footerView else { return TableView_Row_HeaderFooter_Heights.section_footer_none.rawValue}
        switch self.footerHeight {
        case .dynamic:
            return TableView_Row_HeaderFooter_Heights.estimated_section_footer.rawValue
        case let.require(height):
            return height
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension GenericTableViewController {
    func scrollToSelectedIndex(indexPath: IndexPath, animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
        }
    }
}

extension GenericTableViewController {
    func reloadSections(index: Int, items: [RegisterTableViewCellType]) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanUp(items: items)
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections(NSIndexSet(index: index) as IndexSet, with: .none)
            self?.tableView.endUpdates()
        }
    }
    
    func reloadRows(index: Int, section: Int, items: [RegisterTableViewCellType]) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanUp(items: items)
            self?.tableView.beginUpdates()
            self?.tableView.reloadRows(at:[IndexPath(item: index, section: section)], with: .none)
            self?.tableView.endUpdates()
        }
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


