//
//  SCCameraViewController.swift
//  SprintCamera
//
//  Created by Bui Hai on 9/5/15.
//  Copyright (c) 2015 vn.haibui. All rights reserved.
//

import UIKit

public class SCCameraViewController: UIViewController {
    
    @IBOutlet weak var previewView: SCPreviewView!
    var cameraController : SCCameraController? = nil
    
    public static func createDefaultCameraViewController () -> SCCameraViewController {
        
        let vcToReturn = SCCameraViewController(nibName: "DefaultView", bundle: NSBundle(forClass: SCCameraViewController.classForCoder()))
        
        return vcToReturn
        
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        cameraController = SCCameraController()
        var error : NSError? = nil
        if cameraController!.setUp(&error) {
            
            previewView.session = cameraController?.session
            cameraController?.startSession()
            
        }
        
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction public func capture(sender: AnyObject) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
