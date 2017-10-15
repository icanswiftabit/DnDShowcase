//
//  PlaceholderCollectionCell.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import PureLayout

class PlaceholderCollectionCell: UICollectionViewCell, Reusable {
    
    let progressView = UIProgressView(progressViewStyle: .default)
    var progress: Progress? {
        didSet {
            guard let progress = progress else { return }
            progressView.setProgress(Float(progress.fractionCompleted), animated: false)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        decorate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(progressView)
        progressView.autoPinEdgesToSuperviewEdges()
        
    }
    
    func decorate() {
        backgroundColor = .gray
    }
}
