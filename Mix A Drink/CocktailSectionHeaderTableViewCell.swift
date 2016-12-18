//
//  CocktailSectionHeaderTableViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 18.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class CocktailSectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureHeader(withName name: String){
        headerLabel.text = name
        
        let imageName = name.contains("Glass") ? name + " Black" : name
        
        guard let image = UIImage(named: imageName) else {
            return
        }
        
        headerImageView.image = image
    }

}
