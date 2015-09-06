//
//  SCCameraController.swift
//  SprintCamera
//
//  Created by Bui Hai on 9/6/15.
//  Copyright (c) 2015 vn.haibui. All rights reserved.
//

import UIKit
import AVFoundation

protocol SCCameraControllerDelegate {
    
    func deviceConfigurationFailed (error : NSError) -> Void
    func mediaCaptureFailed (error : NSError) -> Void
    func assetLibraryWriteFailed (error : NSError) -> Void
    
}

class SCCameraController: NSObject {
    
    internal var session : AVCaptureSession? = nil
    internal var delegate : SCCameraControllerDelegate? = nil
    var videoQueue : dispatch_queue_t? = nil

    
    func setUp(error : NSErrorPointer) -> Bool {
        
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPresetHigh
        
        let cameraDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if let cameraInput = AVCaptureDeviceInput.deviceInputWithDevice(cameraDevice!, error: error) as? AVCaptureDeviceInput {

            
            if session!.canAddInput(cameraInput) {
                
                session!.addInput(cameraInput)
                
            }

            
        }else {
            
            return false
            
        }
        
        
        
        let imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        if session!.canAddOutput(imageOutput) {
            
            session!.addOutput(imageOutput)
            
        }
        
        videoQueue = dispatch_queue_create("vn.haibui.VideoQueue", nil)
        
        return true
        
    }
    
    
    func startSession() -> Void {
        
        if session!.running == false {
         
            dispatch_async(videoQueue!, { () -> Void in
                
                self.session!.startRunning()
                
            })
            
        }
        
    }
    
    
    func stopSession() -> Void {
        
        if session!.running {
            
            dispatch_async(videoQueue!, { () -> Void in
                
                self.session!.stopRunning()
                
            })
            
        }
        
        
    }
    

    
    
}
