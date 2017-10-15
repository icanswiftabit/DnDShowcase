//
//  CollectionViewController.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import PureLayout
import MobileCoreServices

class CollectionViewControllerWithDelegats: UIViewController {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout())
    var viewModel = DefaultViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "CollectionViewController Delegats"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
    }

    func setupCollection() {
        collectionView.registerClass(CollectionCell.self)
        collectionView.registerClass(PlaceholderCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = .green
        
    }
    
}

extension CollectionViewControllerWithDelegats: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CollectionCell.self, for: indexPath)
        let cat = viewModel.cats[indexPath.row]
        configureCell(cell, with: cat)
        return cell
    }
    
    func configureCell(_ cell: CollectionCell, with cat: Cat) {
        cell.label.text = cat.name
        cell.imageView.image = cat.image
    }
}

extension CollectionViewControllerWithDelegats: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            item.itemProvider.loadObject(ofClass: <#T##NSItemProviderReading.Type#>, completionHandler: <#T##(NSItemProviderReading?, Error?) -> Void#>)
        }
    }
}

extension CollectionViewControllerWithDelegats: UICollectionViewDelegate {
}

extension CollectionViewControllerWithDelegats: UICollectionViewDropDelegate {
    
    // Declare which type or identifiers the collectionView can accept
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: UIImage.self)
        return session.hasItemsConforming(toTypeIdentifiers: [Cat.shareIdentifier, kUTTypeImage as String, kUTTypePlainText as String])
    }
    
    /// Propose what kind of operation you can do based it this is a localDrag or external
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let operation: UIDropOperation = session.localDragSession == nil ? .copy : .move
        let intent = UICollectionViewDropIntent.insertAtDestinationIndexPath
        let dropProposal = UICollectionViewDropProposal(operation: operation, intent: intent)
        return dropProposal
    }
    
    /// Handle drop
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        /// Simple drop
//        coordinator.session.loadObjects(ofClass: Cat.self) { cats in
//            collectionView.performBatchUpdates({
//                for cat in cats as! [Cat] {
//                    self.viewModel.cats.insert(cat, at: destinationIndexPath.row)
//                }
//                collectionView.reloadSections(IndexSet(integer: destinationIndexPath.section))
//            })
//        }
        
        /// Distinct if this is a local drag
//        coordinator.session.loadObjects(ofClass: Cat.self) { cats in
//            DispatchQueue.main.async {
//            if coordinator.session.localDragSession != nil, let previousIndex = self.viewModel.cats.index(where: { $0.name == cat.name }) {
//                self.viewModel.cats.swapAt(previousIndex, destinationIndexPath.row)
//            } else {
//                self.viewModel.cats.insert(cat, at: destinationIndexPath.row)
//            }
//                collectionView.reloadSections(destinationIndexPath.section)
//            }
//       }
        
        /// Drop with placeholders
//        for item in coordinator.items {
//            let placeholder = UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: PlaceholderCollectionCell.identifier)
//            let placeholderContext = coordinator.drop(item.dragItem, to: placeholder)
//            item.dragItem.itemProvider.loadObject(ofClass: Cat.self) { cat, error in
//                DispatchQueue.main.async {
//                    placeholderContext.commitInsertion { insertionIndexPath in
//                        self.viewModel.cats.insert(cat as! Cat, at: insertionIndexPath.row)
//                    }
//                }
//            }
//        }
//        coordinator.session.progressIndicatorStyle = .none
    }
}

extension CollectionViewControllerWithDelegats: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider(object: viewModel.cats[indexPath.row])
        return [UIDragItem(itemProvider: provider)]
    }
}
