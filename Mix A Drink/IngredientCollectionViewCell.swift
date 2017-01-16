//
//  IngredientCollectionViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 18.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    func configureCell(forIngredient ingredient: Ingredient) {
        guard let name = ingredient.name else { return }
        
        ingredientNameLabel.text = name
        
        if ingredient.isAvailible {
            setImage(selected: true, forIngredient: ingredient)
        } else {
            setImage(selected: false, forIngredient: ingredient)
        }
    }
    
    func setImage(selected: Bool, forIngredient ingredient: Ingredient) {
        if selected {
            ingredientImageView.image = UIImage(data: ingredient.imageSelected as! Data)
        } else {
            ingredientImageView.image = UIImage(data: ingredient.imageGreyed as! Data)
        }
    }
    
}
