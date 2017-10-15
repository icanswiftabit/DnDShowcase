//
//  CollectionCell.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import PureLayout

class CollectionCell: UICollectionViewCell, Reusable {
    let label = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        decorate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        
        imageView.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
        imageView.autoMatch(.height, to: .height, of: contentView, withMultiplier: 0.6)
        
        label.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
        label.autoMatch(.height, to: .height, of: contentView, withMultiplier: 0.3)
    }
    
    func decorate() {
        backgroundColor = .clear
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
}
