//
//  ViewController.swift
//  UseMDKitsApp
//
//  Created by Xiaoxi Pang on 10/27/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import UIKit
import MDKits

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ageAdviser = AgeAdviser()
        print("Age: \(ageAdviser.age)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

