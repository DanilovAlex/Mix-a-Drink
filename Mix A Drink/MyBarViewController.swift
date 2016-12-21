//
//  MyBarViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 16.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class MyBarViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var alcoholContainerView: UIView!
    @IBOutlet weak var nonAlcoholContainerView: UIView!
    @IBOutlet weak var cocktailsContainerView: UIView!
    
    weak var cocktailTableVC: GroupedCocktailTableViewController!
    
    weak var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alcoholContainerView.isHidden = false
        nonAlcoholContainerView.isHidden = true
        cocktailsContainerView.isHidden = true
        instructionLabel.text = "Instruction:\nMark Alcohol Drinks You Have"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            alcoholContainerView.isHidden = false
            nonAlcoholContainerView.isHidden = true
            cocktailsContainerView.isHidden = true
            instructionLabel.text = "Instruction:\nMark Alcohol Drinks You Have"
        case 1:
            alcoholContainerView.isHidden = true
            nonAlcoholContainerView.isHidden = false
            cocktailsContainerView.isHidden = true
            instructionLabel.text = "Instruction:\nMark Other Ingridients You Have"
        case 2:
            alcoholContainerView.isHidden = true
            nonAlcoholContainerView.isHidden = true
            cocktailsContainerView.isHidden = false
            instructionLabel.text = "With the selected ingridients\nyou can make the following cocktails:"
            cocktailTableVC.reloadTable()
        default:
            break
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case "alcoholSegue":
            let destinationVC = segue.destination as! IngridientsCollectionViewController
            destinationVC.managedObjectContext = managedObjectContext
            destinationVC.ingridientType = .Alcohol
        case "nonAlcoholSegue":
            let destinationVC = segue.destination as! IngridientsCollectionViewController
            destinationVC.managedObjectContext = managedObjectContext
            destinationVC.ingridientType = .NonAlcohol
        case "cocktailsSegue":
            let destinationVC = segue.destination as! GroupedCocktailTableViewController
            destinationVC.managedObjectContext = managedObjectContext
            cocktailTableVC = destinationVC
            destinationVC.searchPredicate = NSPredicate(format: "ANY requiresAlcohol.@count == SUBQUERY(requiresAlcohol, $requiresAlcohol, $requiresAlcohol.isAvailible == YES).@count AND requiresNonAlcohol.@count == SUBQUERY(requiresNonAlcohol, $requiresNonAlcohol, $requiresNonAlcohol.isAvailible == YES).@count")
        default:
            break
        }
        
    }
}
