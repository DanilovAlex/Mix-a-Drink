//
//  IngridientTableViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class IngridientTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    weak var context: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<Ingridient>!
    var typeToDisplay: IngridientType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request:NSFetchRequest<NSFetchRequestResult>?
        
        switch typeToDisplay! {
        case IngridientType.Alcohol:
            request = Alcohol.fetchRequest()
        case IngridientType.NonAlcohol:
            request = NonAlcohol.fetchRequest()
        }
        
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let typeSortDescriptor = NSSortDescriptor(key: "type", ascending: true)
        request?.sortDescriptors = [typeSortDescriptor, nameSortDescriptor]
        
        //let predicate = NSPredicate(format: "type == %@", NSString(string: "Spirits") as CVarArg)
        //request.predicate = predicate
        
        resultsController = NSFetchedResultsController(fetchRequest: request as! NSFetchRequest<Ingridient>, managedObjectContext: context!, sectionNameKeyPath: "type", cacheName: nil)
        resultsController.delegate = self
        
        do {
            try resultsController.performFetch()
        } catch {
            fatalError("Could not perform fetch request")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return resultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientCell", for: indexPath) as! IngridientTableViewCell
        
        let ingridient = resultsController.object(at: indexPath)
        
        cell.configureCell(forIngridient: ingridient)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[section]
        
        let header = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! IngridientSectionHeaderTableViewCell
        header.configureHeader(withName: sectionInfo.name)
        
        return header as UIView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "cocktails" {
            let destinationVC = segue.destination as! CocktailListTableViewController
            destinationVC.context = context
            
            let selectedIndex = tableView.indexPathForSelectedRow!
            let ingridient = resultsController.object(at: selectedIndex)
            
            switch typeToDisplay! {
            case IngridientType.Alcohol:
                destinationVC.searchPredicate = NSPredicate(format: "requiresAlcohol CONTAINS %@", ingridient as CVarArg)
            case IngridientType.NonAlcohol:
                destinationVC.searchPredicate = NSPredicate(format: "requiresNonAlcohol CONTAINS %@", ingridient as CVarArg)
            }
            
            destinationVC.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        }
    }

}
