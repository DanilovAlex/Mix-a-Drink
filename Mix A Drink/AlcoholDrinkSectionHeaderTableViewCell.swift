//
//  AlcoholDrinkSectionHeaderTableViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 21.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class AlcoholDrinkSectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureHeader(withName name: String) {
        headerName.text = name
        
        if let image = UIImage(named: name) {
            headerImageView.image = image
        } else {
            headerImageView.image = UIImage(named: "Image Not Found")!
        }
    }

}
