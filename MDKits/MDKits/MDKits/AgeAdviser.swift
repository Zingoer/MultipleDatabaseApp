//
//  AgeAdviser.swift
//  MultipleServerFramework
//
//  Created by Xiaoxi Pang on 10/27/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import Foundation
import CoreData

public class AgeAdviser {
    
    lazy var coreDataStack2 = CoreDataStack2()
    var managedContext: NSManagedObjectContext!
    var currentSecondEntity: SecondEntity!
    
    public var age:String{
        get{
            return currentSecondEntity.age ?? ""
        }
    }
    
    public init(){
        managedContext = coreDataStack2.context
        
        let entities: NSDictionary = (managedContext.persistentStoreCoordinator?.managedObjectModel.entitiesByName)!
        debugPrint("\(entities.allKeys)")
        let secondEntity = NSEntityDescription.entityForName("SecondEntity", inManagedObjectContext: managedContext)
        let age = "27"
        let entityFetch = NSFetchRequest(entityName: "SecondEntity")
        entityFetch.predicate = NSPredicate(format: "age == %@", age)
        
        do{
            let results = try managedContext.executeFetchRequest(entityFetch) as! [SecondEntity]
            
            if results.count > 0{
                currentSecondEntity = results.first
            }else{
                currentSecondEntity = SecondEntity(entity: secondEntity!, insertIntoManagedObjectContext: managedContext)
                currentSecondEntity.age = age
                try managedContext.save()
            }
        }catch let error as NSError{
            print("Error: \(error), Description \(error.localizedDescription)")
        }
    }
}