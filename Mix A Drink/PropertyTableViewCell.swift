//
//  PropertyTableViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 24.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var propertyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(forProperty property: Property){
        propertyNameLabel.text = property.name
        propertyImageView.image = UIImage(data: property.imageDark as! Data)
    }
}
