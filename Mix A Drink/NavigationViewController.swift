//
//  NavigationViewController.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 26.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Courgette-Regular", size: 20)!]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont(name: "Courgette-Regular", size: 20)!, NSForegroundColorAttributeName: UIColor.black], for: UIControlState.normal)
        navigationBar.tintColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
