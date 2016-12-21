//
//  AlcoholDrinkTableViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 21.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class AlcoholDrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var alcoholNameLabel: UILabel!
    @IBOutlet weak var alcoholImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(alcohol: Alcohol) {
        alcoholNameLabel.text = alcohol.name
        alcoholImageView.image = UIImage(data: alcohol.image as! Data)
    }
}
