//
//  PropertyTableViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 24.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class PropertyTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    weak var context: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<Property>!
    var typeToDisplay: PropertyType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var request:NSFetchRequest<NSFetchRequestResult>?
        
        switch typeToDisplay! {
        case PropertyType.GlassProperty:
            request = Glass.fetchRequest()
        case PropertyType.StrengthProperty:
            request = Strength.fetchRequest()
        case PropertyType.ColorProperty:
            request = Color.fetchRequest()
        }
        
        request?.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        
        resultsController = NSFetchedResultsController(fetchRequest: request as! NSFetchRequest<Property>, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertyTableViewCell

        let cocktailProperty = resultsController.object(at: indexPath)
        
        cell.configureCell(forProperty: cocktailProperty)
        
        return cell
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
        if segue.identifier! == "cocktails" {
            let destinationVC = segue.destination as! CocktailListTableViewController
            destinationVC.context = context
        
            let selectedIndex = tableView.indexPathForSelectedRow!
            let cocktailProperty = resultsController.object(at: selectedIndex)
            
            switch typeToDisplay! {
            case PropertyType.GlassProperty:
                destinationVC.searchPredicate = NSPredicate(format: "glass = %@", cocktailProperty as CVarArg)
            case PropertyType.StrengthProperty:
                destinationVC.searchPredicate = NSPredicate(format: "strength = %@", cocktailProperty as CVarArg)
            case PropertyType.ColorProperty:
                destinationVC.searchPredicate = NSPredicate(format: "color = %@", cocktailProperty as CVarArg)
            }
        }
    }
    

}
