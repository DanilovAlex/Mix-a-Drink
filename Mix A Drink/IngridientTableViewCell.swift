//
//  IngridientTableViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngridientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingridientNameLabel: UILabel!
    @IBOutlet weak var ingridientImageView: UIImageView!
    
    func configureCell(forIngridient ingridient: Ingridient) {
        ingridientNameLabel.text = ingridient.name
        ingridientImageView.image = UIImage(data: ingridient.image as! Data)
    }

}
