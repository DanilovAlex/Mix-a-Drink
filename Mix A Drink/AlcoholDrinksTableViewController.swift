//
//  AlcoholDrinksTableViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 21.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class AlcoholDrinksTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    weak var managedObjectContext: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<Alcohol>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSFetchRequest<Alcohol>(entityName: "Alcohol")
        
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let typeSortDescriptor = NSSortDescriptor(key: "type", ascending: true)
        request.sortDescriptors = [typeSortDescriptor, nameSortDescriptor]
        
        //let predicate = NSPredicate(format: "type == %@", NSString(string: "Spirits") as CVarArg)
        //request.predicate = predicate
        
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: "type", cacheName: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "alcoholCell", for: indexPath) as! AlcoholDrinkTableViewCell

        let alcohol = resultsController.object(at: indexPath)
        
        cell.configureCell(alcohol: alcohol)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[section]
        
        let header = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! AlcoholDrinkSectionHeaderTableViewCell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cocktailsFromDrink" {
            let destinationVC = segue.destination as! GroupedCocktailTableViewController
            destinationVC.managedObjectContext = managedObjectContext
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let alcoholDrink = resultsController.object(at: selectedIndexPath)
            
            destinationVC.searchPredicate = NSPredicate(format: "requiresAlcohol CONTAINS %@", alcoholDrink)
        }
    }
    

}
