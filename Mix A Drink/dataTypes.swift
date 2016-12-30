//
//  dataTypes.swift
//  Mix A Drink
//
//  Created by Alexander on 13.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import Foundation

enum DataType: String {
    case Cocktail = "cocktail"
    case Alcohol = "alcohol"
    case NonAlcohol = "nonalcohol"
    case Glass = "glass"
    case Strength = "strength"
    case Color = "color"
}

let allEntities:[DataType] = [.Alcohol, .NonAlcohol, .Glass, .Strength, .Color, .Cocktail]

enum IngridientType: String {
    case Alcohol = "Alcohol"
    case NonAlcohol = "NonAlcohol"
}

enum PropertyType: String {
    case GlassProperty = "glass"
    case StrengthProperty = "strength"
    case ColorProperty = "color"
}

