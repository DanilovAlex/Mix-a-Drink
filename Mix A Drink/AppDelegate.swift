//
//  AppDelegate.swift
//  Mix A Drink DB Load Check
//
//  Created by Alexander on 23.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabBarController = window?.rootViewController as! UITabBarController
        
        // MARK: - First Tab Configuration - Cocktails
        
        var navigationController = tabBarController.viewControllers?[0] as! UINavigationController
        let navigationTable = navigationController.topViewController as! NavigationTableViewController
        navigationTable.context = coreData.persistentContainer.viewContext
        
        // MARK: - Second Tab Configuration - My Bar
        
        navigationController = tabBarController.viewControllers?[1] as! UINavigationController
        let myBarController = navigationController.topViewController as! MyBarViewController
        myBarController.context = coreData.persistentContainer.viewContext
        
        // MARK: - Third Tab Configuration - Favorites
        
        navigationController = tabBarController.viewControllers?[2] as! UINavigationController
        let cocktailsListTable = navigationController.topViewController as! CocktailListTableViewController
        cocktailsListTable.context = coreData.persistentContainer.viewContext
        cocktailsListTable.searchPredicate = NSPredicate(format: "isFavorite = YES")
        cocktailsListTable.navigationItem.title = "Favorite Cocktails"
        cocktailsListTable.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // MARK: - Fourth Tab Configuration - Search

        navigationController = tabBarController.viewControllers?[3] as! UINavigationController
        let cocktailsListSearchTable = navigationController.topViewController as! CocktailListWithSearchViewController
        cocktailsListSearchTable.context = coreData.persistentContainer.viewContext
        
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
}

