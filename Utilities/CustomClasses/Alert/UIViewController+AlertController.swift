//
//  UIViewController+ActionSheet.swift
//  Glyff
//
//  Created by Myroslav Pomazan on 2017-03-28.
//  Copyright © 2017 Two Tall Totems. All rights reserved.
//

import Foundation
import UIKit
import Photos

typealias openCameraCallBackBlock = (_ selectedImage : UIImage?) ->Void
typealias openCameraVideoCallBackBlock = (_ videoURL : URL?) ->Void
var cameraCallBackBlock :openCameraCallBackBlock?
var cameraVideoCallBackBlock :openCameraVideoCallBackBlock?
var cameraController : UIViewController?

enum cameraMediaType {
    case Image
    case Video
}

extension UIViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //Camera Picker
    public func showAlert(title: String?, message: String?) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        actionSheet.addAction(okAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    public func displayAlert(_ controller : AnyObject ,
                             aStrMessage :String ,
                             aCancelBtn :String ,
                             aOKBtn :String,
                             completion : ((Int) -> Void)?) -> Void {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: Constant.AppName, message: aStrMessage, preferredStyle: .alert)
            let aOkAction = UIAlertAction.init(title: aOKBtn, style: .default) { (UIAlertAction) in
                completion?(0)
            }
            let aCancelAction = UIAlertAction.init(title: aCancelBtn, style: .cancel) { (UIAlertAction) in
                completion?(1)
            }
            alertController.addAction(aOkAction)
            alertController.addAction(aCancelAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    public func displayChildController(ChildVC: UIViewController , toViewController  RootVC : UIViewController){
        RootVC.addChildViewController(ChildVC)
        RootVC.view.addSubview(ChildVC.view)
        ChildVC.didMove(toParentViewController: RootVC)
    }
    
    public  func hideChildController(ChildVC: UIViewController) {
        ChildVC.willMove(toParentViewController: nil)
        ChildVC.view.removeFromSuperview()
        ChildVC.removeFromParentViewController()
    }
    
    public func removeAllChildControllers(rootVC : UIViewController) {
        if rootVC.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = rootVC.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
    }
    
    public func showAlert(controller : AnyObject ,
                          aStrMessage :String? ,
                          style : UIAlertControllerStyle ,
                          aCancelBtn :String? ,
                          aDistrutiveBtn : String?,
                          otherButtonArr : Array<String>?,
                          completion : ((Int, String) -> Void)?) -> Void {
        
        
        
        let alert = UIAlertController.init(title: Constant.AppName, message: aStrMessage, preferredStyle: style)
        
        if let strDistrutiveBtn = aDistrutiveBtn {
            
            let aStrDistrutiveBtn = strDistrutiveBtn
            
            alert.addAction(UIAlertAction.init(title: aStrDistrutiveBtn, style: .destructive, handler: { (UIAlertAction) in
                
                completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strDistrutiveBtn)
                
            }))
        }
        
        if let strCancelBtn = aCancelBtn {
            
            let aStrCancelBtn = strCancelBtn
            
            alert.addAction(UIAlertAction.init(title: aStrCancelBtn, style: .cancel, handler: { (UIAlertAction) in
                
                if ( aDistrutiveBtn != nil ) {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count + 1 : 1, strCancelBtn)
                } else {
                    completion?(otherButtonArr != nil ? otherButtonArr!.count : 0, strCancelBtn)
                }
                
            }))
        }
        
        if let arr = otherButtonArr {
            
            for (index, value) in arr.enumerated() {
                
                let aValue = value
                
                alert.addAction(UIAlertAction.init(title: aValue, style: .default, handler: { (UIAlertAction) in
                    
                    completion?(index, value)
                    
                }))
            }
        }
        
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    public func showAlertWithOkButton(controller : AnyObject ,
                                      aStrMessage :String? ,
                                      completion : ((Int, String) -> Void)?) -> Void {
        DispatchQueue.main.async(execute: {
            self.showAlert(controller: controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: nil, aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: completion)
        })
        
    }
    
    public func showAlertWithCancelButton(controller : AnyObject ,
                                          aStrMessage :String? ,
                                          completion : ((Int, String) -> Void)?) -> Void {
        DispatchQueue.main.async(execute: {
            self.showAlert(controller: controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: nil, completion: completion)
        })
        
    }
    
    public func showDeleteAlert(controller : AnyObject ,
                                aStrMessage :String? ,aStrDeleteTitle:String?,
                                completion : ((Int, String) -> Void)?) -> Void {
        DispatchQueue.main.async(execute: {
            self.showAlert(controller: controller, aStrMessage: aStrMessage, style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: aStrDeleteTitle, otherButtonArr: nil, completion: completion)
        })
    }
    
    public func showActionsheetForImagePicker(controller : AnyObject ,
                                              aStrMessage :String? ,
                                              completion : ((Int, String) -> Void)?) -> Void {
        DispatchQueue.main.async(execute: {
            
            
            
            self.showAlert(controller: controller, aStrMessage: aStrMessage, style: .actionSheet, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["Use Gallery", "Use Camera"], completion: completion)
            
            
        })
    }
    
    //For Camera Actions:- 
    func openCameraInController(_ controller:UIViewController, mediaType : cameraMediaType, position : CGRect? ,completionBlock:@escaping openCameraCallBackBlock)
        
    {
        cameraCallBackBlock = completionBlock
        cameraController = controller
        DispatchQueue.main.async(execute: {
            
            
            UIAlertController.showActionsheetForImagePicker(controller, cameramediaType : mediaType, aStrMessage: nil, completion:{ (index, strTitle) in
                
                if index == 1{
                    
                    if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Camera not available.", completion: nil)
                    }
                    else{
                        
                        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                        
                        if (authStatus == .authorized){
                            self.openPickerWithCamera(true)
                        }else if (authStatus == .notDetermined){
                            
                            print("Camera access not determined. Ask for permission.")
                            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                                if(granted)
                                {
                                    if mediaType == cameraMediaType.Image {
                                        
                                        self.openPickerWithCamera(true)
                                    }else{
                                        self.openPickerWithCameraVideo(true)
                                    }
                                }
                            })
                        }else if (authStatus == .restricted){
                            UIAlertController.showAlertWithOkButton(controller, aStrMessage: "You've been restricted from using the camera on this device. Please contact the device owner so they can give you access.", completion:nil)
                            
                            
                            
                        }else{
                            
                            UIAlertController.showAlert(controller, aStrMessage: "It looks like your privacy settings are preventing us from accessing your camera. Goto Setting ->Camera: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                                
                                if index == 0{
                                    
                                    UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                                    
                                }
                            })
                        }
                    }
                }else if index == 0{
                    
                    let authorizationStatus = PHPhotoLibrary.authorizationStatus()
                    
                    if (authorizationStatus == .authorized) {
                        // Access has been granted.
                        self.openPickerWithCamera(false)
                    }else if (authorizationStatus == .restricted) {
                        // Restricted access - normally won't happen.
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "You've been restricted from using the photos on this device. Please contact the device owner so they can give you access.", completion:nil)
                        
                    }else if (authorizationStatus == .notDetermined) {
                        
                        // Access has not been determined.
                        PHPhotoLibrary.requestAuthorization({ (status) in
                            if (status == .authorized) {
                                // Access has been granted.
                                self.openPickerWithCamera(false)
                            }else {
                                // Access has been denied.
                            }
                        })
                    }else{
                        UIAlertController.showAlert(controller, aStrMessage: "It looks like your privacy settings are preventing us from accessing your photos. Goto Setting ->Photos: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                            
                            if index == 0{
                                if let URL = URL(string: UIApplicationOpenSettingsURLString) {
                                    UIApplication.shared.openURL(URL)
                                }
                                //  UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
                            }
                        })
                    }
                }
            })
        })
    }
    
    //For Camera Actions:-
    func openCameraVideoInController(_ controller:UIViewController, mediaType : cameraMediaType, position : CGRect? ,completionBlock:@escaping openCameraVideoCallBackBlock)
        
    {
        cameraVideoCallBackBlock = completionBlock
        cameraController = controller
        DispatchQueue.main.async(execute: {
            
            
            UIAlertController.showActionsheetForImagePicker(controller, cameramediaType : mediaType, aStrMessage: nil, completion:{ (index, strTitle) in
                
                if index == 0{
                    
                    if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                        UIAlertController.showAlertWithOkButton(controller, aStrMessage: "Camera not available.", completion: nil)
                    }
                    else{
                        
                        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                        
                        if (authStatus == .authorized){
                            self.openPickerWithCameraVideo(true)
                        }else if (authStatus == .notDetermined){
                            
                            print("Camera access not determined. Ask for permission.")
                            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                                if(granted)
                                {
                                    self.openPickerWithCameraVideo(true)
                                }
                            })
                        }else if (authStatus == .restricted){
                            UIAlertController.showAlertWithOkButton(controller, aStrMessage: "You've been restricted from using the camera on this device. Please contact the device owner so they can give you access.", completion:nil)
                        }else{
                            
                            UIAlertController.showAlert(controller, aStrMessage: "It looks like your privacy settings are preventing us from accessing your camera. Goto Setting ->Camera: turn on.", style: .alert, aCancelBtn: "Cancel", aDistrutiveBtn: nil, otherButtonArr: ["OK"], completion: { (index, strTitle) in
                                
                                if index == 0{
                                    
                                    UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                                    
                                }
                            })
                        }
                    }
                }
            })
        })
    }
    
    func openPickerWithCamera(_ isopenCamera:Bool) {
        
        DispatchQueue.main.async(execute: {
            let captureImg = UIImagePickerController()
            captureImg.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            if(isopenCamera){
                captureImg.sourceType = UIImagePickerControllerSourceType.camera
            }else{
                captureImg.sourceType = UIImagePickerControllerSourceType.photoLibrary
            }
            
            captureImg.allowsEditing = false
            cameraController?.present(captureImg, animated: true, completion: nil)
        })
    }
    
    func openPickerWithCameraVideo(_ isopenCamera:Bool) {
        
        DispatchQueue.main.async(execute: {
            let captureImg = UIImagePickerController()
            captureImg.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            if(isopenCamera){
                captureImg.sourceType = UIImagePickerControllerSourceType.camera
            }
            
            captureImg.mediaTypes = ["public.movie"]
            
            captureImg.videoMaximumDuration = TimeInterval(Constant.maxRecordDuration)
            captureImg.videoQuality = .typeMedium
            
            
            captureImg.allowsEditing = false
            cameraController?.present(captureImg, animated: true, completion: nil)
        })
    }
    
    
    
    // MARK: - UIImagePicker Controller Delegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if !picker.allowsEditing {
            
            if((info["UIImagePickerControllerMediaType"] as! String) == "public.image" ){
                if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    self.dismiss(animated: false, completion: { () -> Void in
                        if (cameraCallBackBlock != nil){
                            cameraCallBackBlock!(img)
                        }
                    })
                }
            }
            else if((info["UIImagePickerControllerMediaType"] as! String) == "public.movie" ){
                if ((info[UIImagePickerControllerMediaURL] as? URL) != nil) {
                    
                    let videoURL = info[UIImagePickerControllerMediaURL] as! URL
                    
                    if (cameraVideoCallBackBlock != nil) {
                        cameraVideoCallBackBlock!(videoURL)
                    }
                }
            }
            
        }
        else {
            if let img = info[UIImagePickerControllerEditedImage] as? UIImage{
                
                if (cameraCallBackBlock != nil){
                    
                    cameraCallBackBlock!(img)
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        if (cameraCallBackBlock != nil){
            
            cameraCallBackBlock!(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //Validate Function 
    public   func isValidName(_ nameString: String) -> Bool {
        
        var returnValue = true
        let mobileRegEx =  "[A-Za-z]{3}"  // {3} -> at least 3 alphabet are compulsory.
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = nameString as NSString
            let results = regex.matches(in: nameString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}
