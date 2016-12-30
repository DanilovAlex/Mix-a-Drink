//
//  CocktailDetailsViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 23.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class CocktailDetailsViewController: UIViewController {

    weak var context: NSManagedObjectContext?
    var cocktail: Cocktail!
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailStrengthImageView: UIImageView!
    @IBOutlet weak var cocktailColorImageView: UIImageView!
    @IBOutlet weak var cocktailGlassImageView: UIImageView!
    @IBOutlet weak var cocktailInstructionTextView: UITextView!
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cocktailNameLabel.text = cocktail.name
        
        backgroundImageView.layer.cornerRadius = 10.0
        
        cocktailImageView.layer.cornerRadius = cocktailImageView.frame.height/2
        cocktailImageView.layer.borderColor = UIColor.white.cgColor
        cocktailImageView.layer.borderWidth = 2.0
        cocktailImageView.image = UIImage(data: cocktail.image as! Data)
        cocktailImageView.clipsToBounds = true
        
        cocktailStrengthImageView.image = UIImage(data: cocktail.strength?.imageLight as! Data)
        
        cocktailColorImageView.image = UIImage(data: cocktail.color?.imageLight as! Data)
        
        cocktailGlassImageView.image = UIImage(data: cocktail.glass?.imageLight as! Data)
        
        cocktailInstructionTextView.text = cocktail.instruction
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setButtonImage(ifIsFavorite: cocktail.isFavorite)
    }
    
    func setButtonImage(ifIsFavorite isFavorite: Bool){
        if isFavorite {
            favoritesButton.image = UIImage(named: "Remove from Favorites")
        } else {
            favoritesButton.image = UIImage(named: "Add to Favorites")
        }
    }
    
    @IBAction func favoritesTapped(_ sender: UIBarButtonItem) {
        cocktail.isFavorite = !cocktail.isFavorite
        
        setButtonImage(ifIsFavorite: cocktail.isFavorite)
        
        do {
            try context?.save()
        } catch {
            fatalError("Failed to save context")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RecipeElementCollectionViewController
        destinationVC.cocktail = cocktail
        
        switch segue.identifier! {
        case "alcohol":
            destinationVC.partToDisplay = .Alcohol
        case "nonAlcohol":
            destinationVC.partToDisplay = .NonAlcohol
        default:
            break
        }
    }
    

}
