//
//  CocktailListWithSearchViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class CocktailListWithSearchViewController: CocktailListTableViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Enter Cocktail Name"
        request?.predicate = NSPredicate(value: false)
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search update function
    
    func updateSearchResults(for: UISearchController) {
        
        // Process the search string, remove leading and trailing spaces
        let searchText = searchController.searchBar.text!
        let trimmedSearchString = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !trimmedSearchString.isEmpty {
            
            // Form the search format
            let predicate = NSPredicate(format: "(name contains [cd] %@)", trimmedSearchString)
            
            // We search for the cocktail names containg user entered text
            request?.predicate = predicate
            
        }
        else {
            
            // No predicate menas we get no cocktails
            request?.predicate = NSPredicate(value: false)
        }
        
        reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell
        
        let cocktail = resultsController.object(at: indexPath)
        
        cell.configureSearchCell(forCocktail: cocktail)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
