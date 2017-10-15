//
//  CollectionViewExtensions.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(_ aClass: T.Type) where T: Reusable {
        register(aClass, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ aClass: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
