//
//  RecipeElementCollectionViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 24.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "recipeElementCell"

class RecipeElementCollectionViewController: UICollectionViewController {

    var cocktail: Cocktail!
    var partToDisplay: IngredientType?
    var recipe: [RecipeElement] = []
    var ingredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch partToDisplay! {
        case IngredientType.Alcohol:
            recipe = cocktail.recipeAlcohol?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [AlcoholRecipeElement]
            ingredients = cocktail.requiresAlcohol?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [Alcohol]
        case IngredientType.NonAlcohol:
            recipe = cocktail.recipeNonAlcohol?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [NonAlcoholRecipeElement]
            ingredients = cocktail.requiresNonAlcohol?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [NonAlcohol]
        }
        
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipe.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeElementCollectionViewCell
    
        let recipeElement = recipe[indexPath.row]
        let ingredient = ingredients[indexPath.row]
        
        cell.configureCell(forRecipeElement: recipeElement, andIngredient: ingredient)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
