//
//  CollectionViewControllerWithSimpleInteractionsAndConfigurations.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import PureLayout
import MobileCoreServices

class CollectionViewControllerWithSimpleInteractionsAndConfigurations: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout())
    var viewModel = DefaultViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "CollectionViewController Simple"
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
        collectionView.dataSource = self
        
        // Declare which type or identifiers the view can accept in drop
//        collectionView.pasteConfiguration = UIPasteConfiguration(acceptableTypeIdentifiers: [kUTTypeImage as String])
        collectionView.pasteConfiguration = UIPasteConfiguration(forAccepting: UIImage.self)
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = .green
        
    }
    
    // Handle the drop
    override func paste(itemProviders: [NSItemProvider]) {
        for provider in itemProviders {
            provider.loadObject(ofClass: UIImage.self, completionHandler: { item, error in
                guard error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.viewModel.cats.append(Cat(name: "New cat", image: item as! UIImage))
                    self.collectionView.reloadData()
                    self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
                }
            })
        }
    }
}

extension CollectionViewControllerWithSimpleInteractionsAndConfigurations: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CollectionCell.self, for: indexPath)
        let cat = viewModel.cats[indexPath.row]
        cell.label.text = cat.name
        cell.imageView.image = cat.image
        return cell
    }
}
