//
//  RecipeIngridientCollectionViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 15.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class RecipeIngridientCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ingridientAmountLabel: UILabel!
    @IBOutlet weak var ingridientImageView: UIImageView!
    @IBOutlet weak var ingridientNameLabel: UILabel!
    
    public func configureCell (recipeDetail: Recipe){
        ingridientAmountLabel.text = recipeDetail.ingridientAmount
        
        ingridientNameLabel.text = recipeDetail.ingridientName
        
        if let image = UIImage(named: recipeDetail.ingridientName!) {
            ingridientImageView.image = image
        } else {
            ingridientImageView.image = UIImage(named: "Image Not Found")!
        }
    }
}
