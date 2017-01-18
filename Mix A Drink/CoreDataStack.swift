//
//  CoreDataStack.swift
//  Mix A Drink
//
//  Created by Alexander on 12.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Mix_A_Drink")
        
        let seededData: String = "Mix_A_Drink"
        var persistentStoreDescriptions: NSPersistentStoreDescription
        
        let storeUrl = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Mix_A_Drink.sqlite")
        let storeUrlShm = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Mix_A_Drink.sqlite-shm")
        let storeUrlWal = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("Mix_A_Drink.sqlite-wal")
        
        if !FileManager.default.fileExists(atPath: (storeUrl.path)) {
            let seededDataUrl = Bundle.main.url(forResource: seededData, withExtension: "sqlite")
            try! FileManager.default.copyItem(at: seededDataUrl!, to: storeUrl)
            
            let seededDataUrlShm = Bundle.main.url(forResource: seededData, withExtension: "sqlite-shm")
            try! FileManager.default.copyItem(at: seededDataUrlShm!, to: storeUrlShm)

            let seededDataUrlWal = Bundle.main.url(forResource: seededData, withExtension: "sqlite-wal")
            try! FileManager.default.copyItem(at: seededDataUrlWal!, to: storeUrlWal)
            
        }
        
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: storeUrl)]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error \(error),")
            }
        })
        
        return container
        
        
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                if let nserror = error as NSError? {
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}

