//
//  MasterViewController.swift
//  DnDShowcase
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

//    weak var detailViewController: UIViewController?
    let viewControllers = [
        CollectionViewControllerWithSimpleInteractionsAndConfigurations(),
        CollectionViewControllerWithDelegats()
    ]
    var dragableTitels = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        navigationItem.leftBarButtonItem = editButtonItem

//        if let split = splitViewController {
//            let controllers = split.viewControllers
//            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
        
//        tableView.dropDelegate = self
//        tableView.dragDelegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        title = "Cases"
    }

//    override func viewWillAppear(_ animated: Bool) {
////        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//        super.viewWillAppear(animated)
//    }

    // MARK: - Segues

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewControllers.count : dragableTitels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = viewControllers[indexPath.row].title
        } else {
            cell.textLabel?.text = dragableTitels[indexPath.row]
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let controller = viewControllers[indexPath.row]
//            navigationController.push
//            detailViewController?.navigationController?.pushViewController(controller, animated: false)
            navigationController?.pushViewController(controller, animated: true)
//            detailViewController?.present(controller, animated: true)
        }
    }
}

extension MasterViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var operation: UIDropOperation!
        if destinationIndexPath?.section == 0 {
            operation = .forbidden
        } else {
            operation = session.localDragSession != nil ? .move : .copy
        }
        return UITableViewDropProposal(operation: operation)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("wee drop")
        coordinator.session.loadObjects(ofClass: NSString.self) { objects in
            for object in objects as! [NSString] {
                print("nsstring")
                print(object)
            }
        }
        coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
            for object in objects as! [UIImage] {
                print("images")
                print(object)
            }
        }
    }

}

