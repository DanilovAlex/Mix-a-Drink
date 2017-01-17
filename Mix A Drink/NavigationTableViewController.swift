//
//  NavigationTableViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 23.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class NavigationTableViewController: UITableViewController {

    weak var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "all":
            let destinationVC = segue.destination as! CocktailListTableViewController
            destinationVC.context = context
        case "color":
            let destinationVC = segue.destination as! PropertyTableViewController
            destinationVC.context = context
            destinationVC.typeToDisplay = PropertyType.ColorProperty
        case "strength":
            let destinationVC = segue.destination as! PropertyTableViewController
            destinationVC.context = context
            destinationVC.typeToDisplay = PropertyType.StrengthProperty
        case "glass":
            let destinationVC = segue.destination as! PropertyTableViewController
            destinationVC.context = context
            destinationVC.typeToDisplay = PropertyType.GlassProperty
        case "drinks":
            let destinationVC = segue.destination as! IngredientTableViewController
            destinationVC.context = context
            destinationVC.typeToDisplay = IngredientType.Alcohol
        default:
            break
        }
        
    }
    

}
