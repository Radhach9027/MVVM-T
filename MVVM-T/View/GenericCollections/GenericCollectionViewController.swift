import UIKit

final class GenericCollectionViewController: UICollectionViewController {
    var items: [RegisterCollectionViewCellType]
    var sections: Int = 0
    private var cellHandler: (UICollectionViewCell, IndexPath) -> Void
    private var cellTapHandler: (RegisterCollectionViewCellType, IndexPath) -> Void
    
    init(items: [RegisterCollectionViewCellType], sections: Int , flowLayout: UICollectionViewFlowLayout, cellHandler: @escaping (UICollectionViewCell, IndexPath) -> Void, cellTapHandler: @escaping (RegisterCollectionViewCellType, IndexPath) -> Void) {
        self.items = items
        self.sections = sections
        self.cellHandler = cellHandler
        self.cellTapHandler = cellTapHandler
        super.init(collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = .clear;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
     print(" GenericCollectionViewController de-init")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    
    private func register() {
        Set(items.compactMap({$0.reuseIdentifier})).forEach({
            collectionView.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        })
    }
}

extension GenericCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configureCustomCell = items[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configureCustomCell.reuseIdentifier, for: indexPath)
        configureCustomCell.update(cell: cell, indexPath: indexPath)
        cellHandler(cell, indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.row]
        cellTapHandler(item, indexPath)
    }
}

extension GenericCollectionViewController {
    func scrollToSelectedIndex(indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension GenericCollectionViewController {
   public func reloadSections(index: Int, items: [RegisterCollectionViewCellType]) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanUp(items: items)
            self?.collectionView.reloadSections(IndexSet(arrayLiteral: index))
        }
    }
    
  public func reloadRows(index: Int, items: [RegisterCollectionViewCellType], section: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanUp(items: items)
            self?.collectionView.reloadItems(at: [IndexPath(item: index, section: section)])
        }
    }
    
   public func reload(items: [RegisterCollectionViewCellType]) {
        DispatchQueue.main.async { [weak self] in
            self?.cleanUp(items: items)
            self?.collectionView.reloadData()
        }
   }
    
    private func cleanUp(items: [RegisterCollectionViewCellType]) {
        if items.count > 0 {
            self.items.removeAll()
            self.items.append(contentsOf: items)
        }
    }
}

extension UICollectionViewFlowLayout {
    static let gridFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize =  CGSize(width: 200, height: 205)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 3)
        return flowLayout
    }()
}

