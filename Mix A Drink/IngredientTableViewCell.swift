//
//  IngredientTableViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientImageView: UIImageView!
    
    func configureCell(forIngredient ingredient: Ingredient) {
        ingredientNameLabel.text = ingredient.name
        ingredientImageView.image = UIImage(data: ingredient.image as! Data)
    }

}
