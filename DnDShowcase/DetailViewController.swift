//
//  DetailViewController.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Select a case"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
}
