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
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
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

