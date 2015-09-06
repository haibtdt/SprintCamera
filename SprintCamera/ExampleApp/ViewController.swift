//
//  ViewController.swift
//  ExampleApp
//
//  Created by Bui Hai on 9/5/15.
//  Copyright (c) 2015 vn.haibui. All rights reserved.
//

import UIKit
import SprintCamera

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showSprintCamera(sender: AnyObject) {
        
        let defaultCameraVC = SCCameraViewController.createDefaultCameraViewController()
        self.presentViewController(defaultCameraVC, animated: true, completion: nil)
        
    }
}

