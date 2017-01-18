//
//  RecipeElementCollectionViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 24.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class RecipeElementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingredientAmountLabel: UILabel!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientImageView: UIImageView!
    
    func configureCell(forRecipeElement element: RecipeElement, andIngredient ingredient: Ingredient){
        ingredientAmountLabel.attributedText = element.amount?.toAmountString
        ingredientImageView.image = UIImage(named: ingredient.image!)
        ingredientNameLabel.text = element.name
    }
    
}
