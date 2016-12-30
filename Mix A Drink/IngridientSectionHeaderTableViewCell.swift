//
//  IngridientSectionHeaderTableViewCell.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class IngridientSectionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerName: UILabel!
    
    func configureHeader(withName name: String) {
        headerName.text = name
        
    }

}
