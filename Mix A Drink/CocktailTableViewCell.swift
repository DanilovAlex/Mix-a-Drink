//
//  CocktailTableViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 11.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(glass: Glass){
        nameLabel.text = glass.name
        
        let image = UIImage(data: glass.image! as Data)
        myImage.image = image
    }

}
