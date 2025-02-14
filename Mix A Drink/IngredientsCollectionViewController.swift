//
//  IngredientsCollectionViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 18.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ingredientCell"

class IngredientsCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {

    weak var context: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var ingredientType: IngredientType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var request = NSFetchRequest<NSFetchRequestResult>()
        
        if ingredientType == .Alcohol {
            request = NSFetchRequest<Alcohol>(entityName: "Alcohol") as! NSFetchRequest<NSFetchRequestResult>
        } else {
            request = NSFetchRequest<NonAlcohol>(entityName: "NonAlcohol") as! NSFetchRequest<NSFetchRequestResult>
        }
        //let request = NSFetchRequest<Alcohol>(entityName: "Alcohol")
        let typeSortDescriptor = NSSortDescriptor(key: "type", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [typeSortDescriptor, nameSortDescriptor]
        
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context!, sectionNameKeyPath: "type", cacheName: nil)
        resultsController.delegate = self
        
        loadData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        do {
            try context?.save()
        } catch {
            fatalError("Unable to save context")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return resultsController.sections!.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[section]
        
        return sectionInfo.numberOfObjects
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IngredientCollectionViewCell
    
        let ingredient = resultsController.object(at: indexPath)
        
        cell.configureCell(forIngredient: ingredient as! Ingredient)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! IngredientSectionHeaderCollectionReusableView
        
        guard let sections = resultsController.sections else {
            fatalError("No sections in results controller")
        }
        
        let sectionInfo = sections[indexPath.section]
        
        header.setHeaderTitle(sectionInfo.name)
        
        return header
    }
    
    func loadData() {
        do {
            try resultsController.performFetch()
        } catch {
            fatalError("Could not perform fetch request")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! IngredientCollectionViewCell
        
        let ingredient = resultsController.object(at: indexPath) as! Ingredient
        
        ingredient.isAvailible = !ingredient.isAvailible
        
        cell.setImage(selected: ingredient.isAvailible, forIngredient: ingredient)
        
        do {
            try context?.save()
        } catch {
            fatalError("Could not save context")
        }
    }

}
