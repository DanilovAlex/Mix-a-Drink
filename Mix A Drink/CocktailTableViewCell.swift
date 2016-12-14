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
        
        let image = UIImage(data: cocktail.image! as Data)
        cocktailImageView.image = image
    }

}
