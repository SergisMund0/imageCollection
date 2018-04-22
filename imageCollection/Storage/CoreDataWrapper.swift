//
//  CoreDataWrapper.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 22/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import UIKit
import CoreData

/// This class acts as Wrapper for Core Data operations,
/// avoiding the application to have boilerplate code.
final class CoreDataWrapper {
    
    // MARK: Public functions
    
    static func save(entityName: String, value: String, keyPath: String) {
        if let managedObject = CoreDataWrapper.managedObjectFor(entityName: entityName) {
            managedObject.setValue(value, forKey: keyPath)
            
            do {
                if let managedContext = CoreDataWrapper.managedContext() {
                    // Store the object.
                    try managedContext.save()
                }
            } catch let error as NSError {
                print("Could not save \(keyPath) into Core Data. Error: \(error.userInfo)")
            }
        }
    }
    
    static func retrieve(entityName: String, keyPath: String) -> [NSManagedObject]? {
        guard let managedContext = CoreDataWrapper.managedContext() else { return nil }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)

        do {
            let result = try managedContext.fetch(fetchRequest)
            
            return result as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    static func delete(entityName: String) {
        guard let persistentStoreCoordinator = CoreDataWrapper.persistentStoreCoordinator(), let managedContext = CoreDataWrapper.managedContext() else { return }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    static func entityIsEmpty(entity: String) -> Bool {
        if CoreDataWrapper.managedObjectFor(entityName: entity) == nil {
            return true
        }
        return false
    }
    
    // MARK: - Private helper functions
    
    private static func managedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        // Obtains the context for our Core Data models.
        return appDelegate.persistentContainer.viewContext
    }
    
    private static func persistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        // Obtains the persistent store coordinator.
        return appDelegate.persistentContainer.persistentStoreCoordinator
    }
    
    private static func managedObjectFor(entityName: String) ->  NSManagedObject? {
        guard let managedContext = CoreDataWrapper.managedContext() else { return nil }
        
        // Obtains the entity description from the context.
        if let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) {
            // Obtains the managed object for a given entity description
            return NSManagedObject(entity: entityDescription, insertInto: managedContext)
        }
        return nil
    }
}
