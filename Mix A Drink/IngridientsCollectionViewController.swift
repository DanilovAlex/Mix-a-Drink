//
//  IngridientsCollectionViewController.swift
//  Mix A Drink
//
//  Created by Alexander on 18.12.16.
//  Copyright © 2016 Alexander Danilov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ingridientCell"

class IngridientsCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {

    weak var managedObjectContext: NSManagedObjectContext?
    var resultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var ingridientType: IngridientType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var request = NSFetchRequest<NSFetchRequestResult>()
        
        if ingridientType == .Alcohol {
            request = NSFetchRequest<Alcohol>(entityName: "Alcohol") as! NSFetchRequest<NSFetchRequestResult>
        } else {
            request = NSFetchRequest<NonAlcohol>(entityName: "NonAlcohol") as! NSFetchRequest<NSFetchRequestResult>
        }
        //let request = NSFetchRequest<Alcohol>(entityName: "Alcohol")
        let typeSortDescriptor = NSSortDescriptor(key: "type", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [typeSortDescriptor, nameSortDescriptor]
        
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext!, sectionNameKeyPath: "type", cacheName: nil)
        resultsController.delegate = self
        
        loadData()

        // Register cell classes
        //self.collectionView!.register(IngridientCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        do {
            try managedObjectContext?.save()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IngridientCollectionViewCell
    
        let ingridient = resultsController.object(at: indexPath)
        
        cell.configureCell(forIngridient: ingridient as! Ingridient)
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! IngridientSectionHeaderCollectionReusableView
        
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
        let cell = collectionView.cellForItem(at: indexPath) as! IngridientCollectionViewCell
        
        let ingridient = resultsController.object(at: indexPath) as! Ingridient
        
        ingridient.isAvailible = !ingridient.isAvailible
        
        cell.setImage(selected: ingridient.isAvailible, forIngridient: ingridient)
        
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Could not save context")
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
