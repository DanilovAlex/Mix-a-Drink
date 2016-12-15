//
//  CocktailTableViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 11.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var strengthImageView: UIImageView!
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var glassImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cocktail: Cocktail){
        cocktailNameLabel.text = cocktail.name
        
        let cocktailImage = UIImage(data: cocktail.image! as Data)
        cocktailImageView.image = cocktailImage
        
        let strengthImage = UIImage(named: cocktail.strength!)
        strengthImageView.image = strengthImage
        
        let colorImage = UIImage(named: cocktail.color!)
        colorImageView.image = colorImage
        
        let glassImage = UIImage(named: cocktail.glass!)
        glassImageView.image = glassImage
    }

}
