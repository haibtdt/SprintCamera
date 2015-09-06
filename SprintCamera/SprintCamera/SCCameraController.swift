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
    var deviceInput : AVCaptureDeviceInput? = nil
    var captureOutput : AVCaptureStillImageOutput? = nil
    
    
    func setUp(error : NSErrorPointer) -> Bool {
        
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPresetPhoto
        
        let cameraDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if let cameraInput = AVCaptureDeviceInput.deviceInputWithDevice(cameraDevice!, error: error) as? AVCaptureDeviceInput {

            
            if session!.canAddInput(cameraInput) {
                
                deviceInput = cameraInput
                session!.addInput(cameraInput)
                
            }

            
        }else {
            
            return false
            
        }
        
        
        
        let imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        if session!.canAddOutput(imageOutput) {
            
            captureOutput = imageOutput
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
    

    func switchCamera () -> Bool {
    
        
        let deviceToSwitchTo = innactiveCamera()
        var error : NSError? = nil
        if let newInput : AVCaptureDeviceInput = AVCaptureDeviceInput.deviceInputWithDevice(deviceToSwitchTo, error: &error) as? AVCaptureDeviceInput{
            
            session!.beginConfiguration()
            
            session!.removeInput(deviceInput)
            if session!.canAddInput(newInput) {
                
                session!.addInput(newInput)
                deviceInput = newInput
                
            } else {
                
                session!.addInput(deviceInput)
            }
            
            session!.commitConfiguration()
            
        } else {
            
            return false
            
        }
        
        return true
        
    }
    
    
    
    func canSwitchCamera() -> Bool {
        
        
        return cameraCount() > 1
        
    }
    
    
    func cameraCount() -> Int {
        
        return AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count
        
    }
    
    
    func activeCamera () -> AVCaptureDevice {
        
        return deviceInput!.device
        
    }
    
    
    func innactiveCamera () -> AVCaptureDevice? {
        
        if canSwitchCamera() {
            
            let activePosition = activeCamera().position
            if activePosition == .Back {
                
                return cameraDevice(.Front)
                
            } else if activePosition == .Front {
                
                return cameraDevice(.Back)
                
            }
            
        }
        
        return nil
        
    }
    
    func cameraDevice (position : AVCaptureDevicePosition) -> AVCaptureDevice? {
        

            
        let availableDevices : [AVCaptureDevice] = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as! [AVCaptureDevice]
        let activeDevice = activeCamera()
        for device in availableDevices {
            
            if device.position == position {
                
                return device
                
            }
            
        }
        
        
        
        return nil
        
    }
    
}
