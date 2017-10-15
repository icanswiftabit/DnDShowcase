//
//  Reusable.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

protocol Reusable where Self: UICollectionViewCell {
    static var identifier: String { get }
    static var defaultSize: CGSize { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: type(of: self))
    }

   static var defaultSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
   
}
