//
//  CocktailTableViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 23.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var leftPropertyImageView: UIImageView!
    @IBOutlet weak var middlePropertyImageView: UIImageView!
    @IBOutlet weak var rightPropertyImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Cell configuration
    
    func configureCell(forCocktail cocktail: Cocktail){
        cocktailNameLabel.text = cocktail.name
        
        backgroundImageView.layer.cornerRadius = 10.0
        cocktailImageView.clipsToBounds = true
        
        cocktailImageView.image = UIImage(named: cocktail.image!)
        cocktailImageView.layer.cornerRadius = cocktailImageView.frame.height/2
        cocktailImageView.clipsToBounds = true

        leftPropertyImageView.image = UIImage(named: (cocktail.strength?.imageDark!)!)
        middlePropertyImageView.image = UIImage(named: (cocktail.color?.imageDark!)!)
        rightPropertyImageView.image = UIImage(named: (cocktail.glass?.imageDark!)!)
        
    }
    
    func configureSearchCell(forCocktail cocktail: Cocktail){
        cocktailNameLabel.text = cocktail.name
        
        cocktailImageView.image = UIImage(named: cocktail.image!)
        cocktailImageView.layer.cornerRadius = cocktailImageView.frame.height/2
        cocktailImageView.clipsToBounds = true
        
        leftPropertyImageView.image = UIImage(named: (cocktail.strength?.imageDark!)!)
        middlePropertyImageView.image = UIImage(named: (cocktail.color?.imageDark!)!)
        rightPropertyImageView.image = UIImage(named: (cocktail.glass?.imageDark!)!)
    }
    
}
