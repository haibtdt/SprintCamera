//
//  SCPreviewView.swift
//  SprintCamera
//
//  Created by Bui Hai on 9/6/15.
//  Copyright (c) 2015 vn.haibui. All rights reserved.
//

import UIKit
import AVFoundation

public class SCPreviewView: UIView {

    override public class func layerClass() -> AnyClass {
        
        return AVCaptureVideoPreviewLayer.classForCoder()
        
    }
    
    var session : AVCaptureSession? {
        
        set(newSession) {
        

            let myLayer = self.layer as! AVCaptureVideoPreviewLayer
            myLayer.session = newSession
            
        }
        
        get {
        
            let myLayer = self.layer as! AVCaptureVideoPreviewLayer
            return myLayer.session
        
        }
        
    }

}
