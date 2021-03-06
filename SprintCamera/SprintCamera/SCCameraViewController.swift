//
//  SCCameraViewController.swift
//  SprintCamera
//
//  Created by Bui Hai on 9/5/15.
//  Copyright (c) 2015 vn.haibui. All rights reserved.
//

import UIKit

public class SCCameraViewController: UIViewController {
    
    @IBOutlet public weak var previewView: SCPreviewView!
    var cameraController : SCCameraController? = nil
    public var imageAvailableHandler:((UIImage!, NSError!) -> Void)? = nil
    
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
        
        cameraController?.captureStillImage(imageAvailableHandler)
        
    }

    @IBAction func switchCamera(sender: AnyObject) {
        
        cameraController!.switchCamera()
        
        
    }
    
    
    @IBAction func dimiss(sender: AnyObject) {
        
        let error = NSError(domain: "SprintCamera", code: 0, userInfo: [NSLocalizedDescriptionKey:"USER_CANCELLED"])
        imageAvailableHandler?(nil, error)
        
    }
    

}
