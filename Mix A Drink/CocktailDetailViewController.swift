//
//  CocktailDetailViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 14.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

class CocktailDetailViewController: UIViewController, UICollectionViewDataSource {
    var cocktail: Cocktail?
    var alcoholIngridients: [AlcoholRecipePart] = []
    var nonAlcoholIngridients: [NonAlcoholRecipePart] = []
    weak var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailInstructionsLabel: UILabel!
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var strengthImageView: UIImageView!
    @IBOutlet weak var glassImageView: UIImageView!
    @IBOutlet weak var alcoholRecipeDetailsCollectionView: UICollectionView!
    @IBOutlet weak var nonalcoholRecipeDetailsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailNameLabel.text = cocktail?.name

        let cocktailImage = UIImage(data: cocktail?.image! as! Data)
        cocktailImageView.image = cocktailImage
        
        let strengthImage = UIImage(named: (cocktail?.strength)!)
        strengthImageView.image = strengthImage
        
        let colorImage = UIImage(named: (cocktail?.color)!)
        colorImageView.image = colorImage
        
        let glassImage = UIImage(named: (cocktail?.glass)!)
        glassImageView.image = glassImage
        
        cocktailInstructionsLabel.text = cocktail?.instruction
        
        alcoholIngridients = cocktail?.recipeAlcohol?.sortedArray(using: [NSSortDescriptor(key: "ingridientName", ascending: true)]) as! [AlcoholRecipePart]
        nonAlcoholIngridients = cocktail?.recipeNonAlcohol?.sortedArray(using: [NSSortDescriptor(key: "ingridientName", ascending: true)]) as! [NonAlcoholRecipePart]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == alcoholRecipeDetailsCollectionView ? cocktail?.recipeAlcohol?.count : cocktail?.recipeNonAlcohol?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == alcoholRecipeDetailsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alcoholIngridientCell", for: indexPath) as! RecipeIngridientCollectionViewCell
            
            let alcoholIngridient = alcoholIngridients[indexPath.row]
            
            cell.configureCell(recipeDetail: alcoholIngridient)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nonalcoholIngridientCell", for: indexPath) as! RecipeIngridientCollectionViewCell
            
            let nonAlcoholIngridient = nonAlcoholIngridients[indexPath.row]

            cell.configureCell(recipeDetail: nonAlcoholIngridient)
            
            return cell
        }
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
