//
//  AppDelegate.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate/*, UISplitViewControllerDelegate*/ {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
//        let splitViewController = UISplitViewController()
//        let masterViewController = MasterViewController()
//        let detailViewController = DetailViewController()
//        masterViewController.detailViewController = detailViewController
//        let masterNavigationViewController = UINavigationController(rootViewController: masterViewController)
//        let detailNavigationViewController = UINavigationController(rootViewController: detailViewController)
//        splitViewController.viewControllers = [masterNavigationViewController, detailNavigationViewController]
//        splitViewController.delegate = self
        
        let masterViewController = MasterViewController()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [masterViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

//    // MARK: - Split view
//
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
//        return true
//    }

}

