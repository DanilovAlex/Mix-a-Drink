//
//  CocktailListTableViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 23.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class CocktailListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties
    
    weak var context: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<Cocktail>!
    
    var sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    var searchPredicate: NSPredicate?
    var request: NSFetchRequest<Cocktail>?
    var sectionName: String?
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        request = Cocktail.fetchRequest()
        
        if sortDescriptors.count > 0 {
            request?.sortDescriptors = sortDescriptors
        }
        
        if searchPredicate != nil {
            request?.predicate = searchPredicate
        }
        
        request?.fetchBatchSize = gBatchSize
        
        resultsController = NSFetchedResultsController(fetchRequest: request!, managedObjectContext: context!, sectionNameKeyPath: sectionName, cacheName: nil)
        resultsController.delegate = self
        
        setEmptyMessage(message: "No cocktails found!")
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sortButtonPressed(_ sender: Any) {
        if sortButton.title == "A..Z" {
            sortButton.title = "Z..A"
            sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        } else {
            sortButton.title = "A..Z"
            sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        }
        
        request?.sortDescriptors = sortDescriptors
        
        reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName == nil ? 1 : resultsController.sections!.count
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
        
        cell.configureCell(forCocktail: cocktail)

        return cell
    }
    
    // MARK: - Helper functions
    
    func loadData(){
        do {
            try resultsController.performFetch()
        } catch {
            fatalError("Could not perform fetch request")
        }
    }
    
    func reloadData(){
        loadData()
        tableView.reloadData()
        if resultsController.fetchedObjects?.count == 0 {
            self.tableView.backgroundView?.isHidden = false
        } else {
            self.tableView.backgroundView?.isHidden = true
        }
    }
    
    func setEmptyMessage(message:String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        messageLabel.sizeToFit()
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = .none;
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let destinationVC = segue.destination as! CocktailDetailsViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            let cocktail = resultsController.object(at: selectedIndex)
            destinationVC.context = context
            destinationVC.cocktail = cocktail
        }
    }
    

}
