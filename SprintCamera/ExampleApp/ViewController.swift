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
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func showSprintCamera(sender: AnyObject) {
        
        let defaultCameraVC = SCCameraViewController.createDefaultCameraViewController()
        defaultCameraVC.imageAvailableHandler = { image, error in
            
            self.imageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        self.presentViewController(defaultCameraVC, animated: true, completion: nil)
        
    }
}

