//
//  CollectionLayout.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

final class CollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
}

private extension CollectionLayout {
    
    func setup() {
        itemSize = CollectionCell.defaultSize
        minimumLineSpacing = 10
    }
}

