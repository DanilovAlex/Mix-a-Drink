//
//  GroupedCocktailTableViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 16.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class GroupedCocktailTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet var cocktailsTableView: UITableView!
    weak var managedObjectContext: NSManagedObjectContext?
    var sortBy: String?
    var resultsController: NSFetchedResultsController<Cocktail>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSFetchRequest<Cocktail>(entityName: "Cocktail")
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        if sortBy != nil {
            let mainSortDescriptor = NSSortDescriptor(key: sortBy!, ascending: true)
            request.sortDescriptors = [mainSortDescriptor, nameSortDescriptor]
        } else {
            request.sortDescriptors = [nameSortDescriptor]
        }
        
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: sortBy, cacheName: nil)
        resultsController.delegate = self

        loadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell

        let cocktail = resultsController.object(at: indexPath) 
        
        cell.configureCell(cocktail: cocktail)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[section]
        
        let header = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! CocktailSectionHeaderTableViewCell
        header.configureHeader(withName: sectionInfo.name)
        
        return header as UIView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: - Load Data Function
    
    func loadData() {
        do {
            try resultsController.performFetch()
        } catch {
            fatalError("Could not perform fetch request")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cocktailDetail" {
            let destinationVC = segue.destination as! CocktailDetailViewController
            let selectedIndexPath = cocktailsTableView.indexPathForSelectedRow!
     
            destinationVC.cocktail = resultsController.object(at: selectedIndexPath)
            destinationVC.managedObjectContext = managedObjectContext
        }
    }
    

}
