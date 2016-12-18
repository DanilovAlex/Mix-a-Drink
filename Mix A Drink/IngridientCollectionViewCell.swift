//
//  IngridientCollectionViewCell.swift
//  Mix A Drink
//
//  Created by Alexander on 18.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngridientCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ingridientImageView: UIImageView!
    @IBOutlet weak var ingridientNameLabel: UILabel!
    
    func configureCell(forIngridient ingridient: Ingridient) {
        guard let name = ingridient.name else { return }
        
        ingridientNameLabel.text = name
        
        if ingridient.isAvailible {
            setImage(selected: true, forIngridient: ingridient)
        } else {
            setImage(selected: false, forIngridient: ingridient)
        }
    }
    
    func setImage(selected: Bool, forIngridient ingridient: Ingridient) {
        guard var name = ingridient.name else { return }
        
        name += selected ? " Selected" : " Greyed"
        
        if let image = UIImage(named: name) {
            ingridientImageView.image = image
        }
        else {
            ingridientImageView.image = UIImage(named: "Image Not Found")!
        }
    }
    
}
