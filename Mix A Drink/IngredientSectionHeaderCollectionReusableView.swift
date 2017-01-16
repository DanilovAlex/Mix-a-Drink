//
//  IngridientSectionHeaderCollectionReusableView.swift
//  Mix A Drink
//
//  Created by Alexander on 19.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngridientSectionHeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var sectionLabel: UILabel!
    
    func setHeaderTitle(_ name: String) {
        sectionLabel.text = name
    }
    
}
