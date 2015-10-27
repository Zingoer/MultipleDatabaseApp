//
//  CoreDataStack2.swift
//  MultipleServerFramework
//
//  Created by Xiaoxi Pang on 10/26/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack2: NSObject {
    
    let modelName = "SecondModel"
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var context: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    private lazy var psc: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.modelName)
        
        print("Database URL: \(url)")
        
        do{
            let options = [NSMigratePersistentStoresAutomaticallyOption:true]
            
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        }catch{
            print("Error adding persistent store.")
        }
        
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = NSBundle(forClass: CoreDataStack2.self).URLForResource(self.modelName, withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()    
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
    
}