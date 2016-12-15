//
//  AppDelegate.swift
//  Mix A Drink
//
//  Created by Alexander on 11.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let processedTypes:[DataType] = [.Alcohol, .NonAlcohol, .Amount, .Glass, .Cocktail]
        
        //Delete all records in the DB
        deleteRecords(forEntities: processedTypes)
            
        //Check for the records needed to be uploaded
        checkDataStore(forEntities: processedTypes)
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        let cocktailTableNavigationController = tabBarController.viewControllers?[0] as! UINavigationController
        let cocktailTableViewController = cocktailTableNavigationController.topViewController as! CocktailTableViewController
        cocktailTableViewController.managedObjectContext = coreData.persistentContainer.viewContext
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }
    
    func checkDataStore(forEntities entities: [DataType]) {
        let context = coreData.persistentContainer.viewContext
        
        for entity in entities {
            var request:NSFetchRequest<NSFetchRequestResult>
            switch entity {
            case .Cocktail:
                request = Cocktail.fetchRequest()
            case .Alcohol:
                request = Alcohol.fetchRequest()
            case .NonAlcohol:
                request = NonAlcohol.fetchRequest()
            case .Glass:
                request = Glass.fetchRequest()
            case .Amount:
                request = Amount.fetchRequest()
            }
            
            do {
                let objectsCount = try context.count(for: request)
                if objectsCount == 0 {
                    print("No records in \(entity.rawValue) entity")
                    uploadData(forEntity: entity)
                }
            } catch {
                fatalError("Failed to count \(entity.rawValue) records!")
            }
        }
    }
    
    func uploadData(forEntity entity: DataType) {
        let context = coreData.persistentContainer.viewContext
        
        let url = Bundle.main.url(forResource: entity.rawValue, withExtension: "json")!
        
        let data = try? Data(contentsOf: url)
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            let jsonArray = jsonResult.value(forKey: entity.rawValue) as! NSArray
            
            print("Proccessing \(entity.rawValue) json")
            
            for json in jsonArray {
                let objectData = json as! [String : AnyObject]
                
                guard let objectName = objectData["name"] as? String else {
                    return
                }
                
                var objectImage:UIImage
                
                if let tryImage = UIImage(named: (entity == .Cocktail ? objectName + ".jpg" : objectName)) {
                    objectImage = tryImage
                } else {
                    objectImage = UIImage(named: "Image Not Found")!
                }
                
                switch entity {
                case .Cocktail:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    let cocktail = Cocktail(context: context)
                    
                    guard let instruction = objectData["instruction"] as? String else {
                        return
                    }
                    
                    guard let color = objectData["color"] as? String else {
                        return
                    }
                    
                    guard let strength = objectData["strength"] as? String else {
                        return
                    }
                    
                    guard let glass = objectData["glass"] as? String else {
                        return
                    }
                    
                    let recipeAlcoholPart = cocktail.recipeAlcohol?.mutableCopy() as! NSMutableSet
                    
                    let alcoholIngridients = objectData["alcoholingridients"] as! NSArray
                    let alcoholAmounts = objectData["alcoholamounts"] as! NSArray
                    
                    for (ingridient, amount) in zip(alcoholIngridients, alcoholAmounts) {
                        let ingridientName = ingridient as! String
                        let amountName = amount as! String
                        
                        let alcoholPart = AlcoholRecipePart(context: context)
                        alcoholPart.ingridientName = ingridientName
                        alcoholPart.ingridientAmount = amountName
                        alcoholPart.ingridientType = IngridientType.Alcohol.rawValue
                        
                        recipeAlcoholPart.add(alcoholPart)
                        print("Found ingridient \(ingridientName) needed \(amountName)")
                    }
                    
                    let recipeNonAlcoholPart = cocktail.recipeNonAlcohol?.mutableCopy() as! NSMutableSet
                    
                    let nonalcoholIngridients = objectData["nonalcoholingridients"] as! NSArray
                    let nonalcoholAmounts = objectData["nonalcoholamounts"] as! NSArray
                    
                    for (ingridient, amount) in zip(nonalcoholIngridients, nonalcoholAmounts) {
                        let ingridientName = ingridient as! String
                        let amountName = amount as! String
                        
                        let nonAlcoholPart = NonAlcoholRecipePart(context: context)
                        nonAlcoholPart.ingridientName = ingridientName
                        nonAlcoholPart.ingridientAmount = amountName
                        nonAlcoholPart.ingridientType = IngridientType.NonAlcohol.rawValue
                        
                        recipeNonAlcoholPart.add(nonAlcoholPart)
                        print("Found ingridient \(ingridientName) needed \(amountName)")
                    }
                    cocktail.recipeAlcohol = recipeAlcoholPart.copy() as? NSSet
                    cocktail.recipeNonAlcohol = recipeNonAlcoholPart.copy() as? NSSet
 
                    cocktail.name = objectName
                    cocktail.instruction = instruction
                    cocktail.color = color
                    cocktail.strength = strength
                    cocktail.glass = glass
                    cocktail.image = NSData.init(data: UIImageJPEGRepresentation(objectImage, 1)!)
                case .Alcohol:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    guard let type = objectData["type"] as? String else {
                        return
                    }
                    
                    guard let strength = objectData["strength"] as? Double else {
                        return
                    }
                    
                    let alcohol = Alcohol(context: context)
                    alcohol.name = objectName
                    alcohol.type = type
                    alcohol.strength = strength
                    alcohol.isAvailible = false
                    alcohol.image = NSData.init(data: UIImagePNGRepresentation(objectImage)!)
                case .NonAlcohol:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    guard let type = objectData["type"] as? String else {
                        return
                    }
                    
                    let nonAlcohol = NonAlcohol(context: context)
                    nonAlcohol.name = objectName
                    nonAlcohol.type = type
                    nonAlcohol.isAvailible = false
                    nonAlcohol.image = NSData.init(data: UIImagePNGRepresentation(objectImage)!)
                case .Glass:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    let glass = Glass(context: context)
                    
                    glass.name = objectName
                    glass.image = NSData.init(data: UIImagePNGRepresentation(objectImage)!)
                case .Amount:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    guard let measure = objectData["measure"] as? String else {
                        return
                    }
                    
                    guard let value = objectData["value"] as? Double else {
                        return
                    }
                    
                    let amount = Amount(context: context)
                    amount.name = objectName
                    amount.measure = measure
                    amount.value = value
                }
            }
            
            coreData.saveContext()
            
        } catch {
            fatalError("Failed to upload \(entity.rawValue) data")
        }
    }
    
    func deleteRecords(forEntities entities: [DataType]) {
        let context = coreData.persistentContainer.viewContext
        
        for entity in entities {
            var request:NSFetchRequest<NSFetchRequestResult>
            switch entity {
            case .Cocktail:
                request = Cocktail.fetchRequest()
            case .Alcohol:
                request = Alcohol.fetchRequest()
            case .NonAlcohol:
                request = NonAlcohol.fetchRequest()
            case .Glass:
                request = Glass.fetchRequest()
            case .Amount:
                request = Amount.fetchRequest()
            }
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            do {
                try context.execute(deleteRequest)
            } catch {
                fatalError("Failed removing \(entity.rawValue) records!")
            }
        }
        
    }
}

