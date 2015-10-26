//
//  ViewController.swift
//  MultipleDatabaseApp
//
//  Created by Xiaoxi Pang on 10/26/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {
    

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    var managedContext: NSManagedObjectContext!
    var currentFirstEntity: FirstEntity!
    var currentSecondEntity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let firstEntity = NSEntityDescription.entityForName("FirstEntity", inManagedObjectContext: managedContext)
        let name = "Zingoer"
        let entityFecth = NSFetchRequest(entityName: "FirstEntity")
        entityFecth.predicate = NSPredicate(format: "name == %@", name)
        
        do{
            let results = try managedContext.executeFetchRequest(entityFecth) as! [FirstEntity]
            
            if results.count > 0{
                currentFirstEntity = results.first
            }else{
                // This just initializes the receiver and inserts it into the specified managed object context
                currentFirstEntity = FirstEntity(entity: firstEntity!,
                    insertIntoManagedObjectContext: managedContext)
                currentFirstEntity.name = name
                try managedContext.save()
            }
            
        }catch let error as NSError{
            print("Error: \(error), Description \(error.localizedDescription)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        label1.text = "\(currentFirstEntity.name!) is \(currentSecondEntity) years old"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

