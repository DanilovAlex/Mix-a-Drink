//
//  RecipeElementCollectionViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 24.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class RecipeElementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingridientAmountLabel: UILabel!
    @IBOutlet weak var ingridientNameLabel: UILabel!
    @IBOutlet weak var ingridientImageView: UIImageView!
    
    func configureCell(forRecipeElement element: RecipeElement, andIngridient ingridient: Ingridient){
        ingridientAmountLabel.attributedText = element.amount?.toAmountString
        ingridientImageView.image = UIImage(data: ingridient.image as! Data)
        ingridientNameLabel.text = element.name
    }
    
}
