//
//  String+Extension.swift
//  Mix A Drink
//
//  Created by Alexander on 16.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var toAmountString: NSAttributedString {
        var resultString = self
        let font = UIFont(name: "HelveticaNeue-Bold", size: 10.0)!
        
        if self.contains("1/2") {
            resultString = self.replacingOccurrences(of: "1/2", with: "½")
        }
        if self.contains("1/4") {
            resultString = self.replacingOccurrences(of: "1/4", with: "¼")
        }
        if self.contains("3/4") {
            resultString = self.replacingOccurrences(of: "3/4", with: "¾")
        }
        
        let resultAttributedString = NSMutableAttributedString(string: resultString)
        
        let numberCharacters = NSCharacterSet.decimalDigits
        
        var numbersRange = (resultString as NSString).rangeOfCharacter(from: numberCharacters)
        
        if numbersRange.location != NSNotFound {
            numbersRange.length += 1
            resultAttributedString.addAttribute(NSFontAttributeName,
                                          value: font,
                                          range: numbersRange)
        }
        
        let fractionCharacters = NSCharacterSet(charactersIn: "½¾¼")
        
        let fractionRange = (resultString as NSString).rangeOfCharacter(from: fractionCharacters as CharacterSet)
        
        if fractionRange.location != NSNotFound {
            
            resultAttributedString.addAttribute(NSFontAttributeName,
                                                value: font,
                                                range: fractionRange)
        }
 
        return resultAttributedString
    }
}
