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
        
        let processedTypes:[DataType] = [.Cocktail, .Alcohol, .NonAlcohol, .Amount, .Glass]
        
        //Delete all records in the DB
        deleteRecords(forEntities: processedTypes)
            
        //Check for the records needed to be uploaded
        checkDataStore(forEntities: processedTypes)
        
        let rootVC = self.window?.rootViewController as! CocktailTableViewController
        rootVC.managedObjectContext = coreData.persistentContainer.viewContext
        
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
                
                let objectImage = UIImage(named: objectName)
                
                switch entity {
                case .Cocktail:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    let cocktail = Cocktail(context: context)
                    
                    cocktail.name = objectName
                case .Alcohol:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    let alcohol = Alcohol(context: context)
                    alcohol.name = objectName
                case .NonAlcohol:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    let nonAlcohol = NonAlcohol(context: context)
                    nonAlcohol.name = objectName
                case .Glass:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    let glass = Glass(context: context)
                    
                    glass.name = objectName
                    glass.image = NSData.init(data: UIImagePNGRepresentation(objectImage!)!)
                case .Amount:
                    print("Proccessing object \(objectName) of \(entity.rawValue) type")
                    
                    let amount = Amount(context: context)
                    amount.name = objectName
                }
            }
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

