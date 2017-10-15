//
//  Shareable.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

protocol Shareable where Self: NSObject {
    static var shareIdentifier: String { get }
}

extension Shareable {
    static var shareIdentifier: String {
        let bundle = Bundle.main.bundleIdentifier!
        let typeString = String(describing: type(of: self))
        return "\(bundle).\(typeString)"
    }
}
