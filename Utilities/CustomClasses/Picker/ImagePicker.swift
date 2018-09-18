//
//  ImagePicker.swift
//  VidVersity
// 
//  Created By: Kushal Panchal, IndiaNIC Infotech Ltd
//  Created on: 22/12/17 11:51 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit
import Photos
import MobileCoreServices

class ImagePicker: NSObject, UINavigationControllerDelegate {
    
    // MARK: - Shared Instance
    
    /// Shared instance of the ImagePicker class
    public static let shared = ImagePicker()
    
    // MARK: - Private Properties
    
    /// typealias block of the conpletion. which has the param of UIImagePickerController and selected info dictionary which can be null.
    typealias imagePickerCompletionBlock = (UIImagePickerController, [String : Any]?) -> Void
    
    /// Property of the Completion Block
    fileprivate var didCompletePicking: imagePickerCompletionBlock?
    
    /// Object of the ImagePicker Controller
    fileprivate var imagePicker: UIImagePickerController // = UIImagePickerController()
    
    override init() {
        imagePicker = UIImagePickerController()
        super.init()
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.videoQuality = .type640x480
        if #available(iOS 11.0, *) {
            imagePicker.videoExportPreset = AVAssetExportPreset640x480
        }
        imagePicker.videoMaximumDuration = (60 * 30) // Max duration = 30 mins
        imagePicker.mediaTypes = [kUTTypeImage as String]
    }
    
    
    // MARK: - Public Method
    
    /// This method will use to select image form native gallery or to capture using camera. ActionSheet will be displayed with these two options and further operation will be execured based on user's selection.
    ///
    ///     ImagePicker.shared.showImagePicker(self, sender: sender) { (imagePicker, info) -> (Void) in <YOUR CODE GOES HERE> }
    ///
    /// - Parameters:
    ///   - controller: Object of controller from which you need to display Image Picker
    ///   - completion: Completion block will be called when user has selected image or operation will be completed.
    public func showImagePicker(_ controller : UIViewController, sender: UIView? = nil , completion : @escaping imagePickerCompletionBlock) -> Void {
        
        // Assign the Block
        didCompletePicking = completion
        
        // Set Message
        let strMessage = appName.localized
        
        // Create Objectc of the UIAlertController
        let alert = UIAlertController(title: nil, message: strMessage, preferredStyle: .actionSheet)
        
        // Add Cancel Action
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        
        // Add Use Camera Option
        alert.addAction(UIAlertAction(title: "Select Camera".localized, style: .default, handler: { (UIAlertAction) in
            
            self.useCamera(controller)
            
        }))
        
        // Add Use Gallery Option
        alert.addAction(UIAlertAction(title: "Selcet From Gallery".localized, style: .default, handler: { (UIAlertAction) in
            
            self.usePhotoLibrary(controller)
            
        }))
        
        // Display Action Sheet
        DispatchQueue.main.async {
            // This will display in PopOver.
            if let popoverController = alert.popoverPresentationController, let view = sender {
                popoverController.sourceView = view.superview
                popoverController.sourceRect = view.frame
                popoverController.permittedArrowDirections = .any
            }
            controller.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - Private Methods

extension ImagePicker {
    
    /// This method will display an Alert on the Screen.
    ///
    /// - Parameters:
    ///   - controller: Object of the controller form which you need to show alert.
    ///   - message: Message which you need to display.
    fileprivate func showAlert(_ controller : UIViewController , message : String) -> Void {
        UIAlertController.showAlertWithOkButton(controller: controller, message: message, completion: nil)
    }
    
    
    
    /// This method will use to display an Alert related to Access permission.
    ///
    /// - Parameters:
    ///   - controller: Object of the controller
    ///   - message: Message which you need to display
    fileprivate func showAlertForEnableAccessPermission(_ controller : UIViewController, message : String) -> Void {
        
        UIAlertController.showAlert(controller: controller, message: message, cancelButton: "Cancel", otherButtons: ["Settings"]) { (index, title) in
            if index == 0 {
                // Settings button click
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        UIApplication.shared.openURL(appSettings)
                    }
                    
                }
            }
        }
    }
    
    
    /// This method will use to check Photo Library Access permission and display Photos
    ///
    /// - Parameter controller: Object of the controller
    public func usePhotoLibrary(_ controller : UIViewController) -> Void {
        
        self.handlePhotoLibraryStatus(PHPhotoLibrary.authorizationStatus(), controller: controller)
        
    }
    
    /// This method will handle the Photo Library's "PHAuthorizationStatus" and displa
    ///
    /// - Parameters:
    ///   - status: PHAuthorizationStatus
    ///   - controller: Object of the controller on which you wanted to display ImagePicker
    fileprivate func handlePhotoLibraryStatus(_ status: PHAuthorizationStatus, controller : UIViewController) -> Void {
        
        switch status {
        case .authorized:
            print("Photos Authorized")
            DispatchQueue.main.async {
//                self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
//                self.imagePicker.delegate = self
//                self.imagePicker.allowsEditing = true
//                self.imagePicker.videoQuality = .type640x480
//                self.imagePicker.videoMaximumDuration = 60
//                self.imagePicker.mediaTypes = [kUTTypeMovie as String] // Pass this value  // kUTTypeImage // kUTTypeMovie
                self.imagePicker.sourceType = .photoLibrary
                controller.present(self.imagePicker, animated: true, completion: nil)
            }
            
        case .denied:
            print("Photos Denied")
            self.showAlertForEnableAccessPermission(controller , message: "You need to enable Photos access from the settings.")
            self.didCompletePicking?(self.imagePicker, nil)
            
        case .restricted:
            print("Photos restricted")
            self.didCompletePicking?(self.imagePicker, nil)
            
        case .notDetermined:
            print("Photos notDetermined")
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.handlePhotoLibraryStatus(status, controller: controller)
            })
            
        }
        
    }
    
    
    
    /// This method will check if Camera is available or not and is the permission is granted to access it or not and then display the Camera for capturing video or photos.
    ///
    /// - Parameter controller: Object of the controller
    public func useCamera(_ controller : UIViewController) -> Void {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
//            MessageBar.show(.error, message: "Camera is not supported in this device.")
            self.didCompletePicking?(self.imagePicker, nil)
            return
        }
        
        // Check for the authorisation status.
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            // Already authorized
            self.openNativeCamera(controller)
        } else {
            
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    // Access allowed
                    self.openNativeCamera(controller)
                } else {
                    // Access denied
                    self.showAlertForEnableAccessPermission(controller , message: "You need to enable Camera access from the settings.")
                    self.didCompletePicking?(self.imagePicker, nil)
                }
            })
            
        }
        
    }
    
    /// This method will open a Native Camera.
    ///
    /// - Parameter controller: Object of the controller
    fileprivate func openNativeCamera(_ controller: UIViewController) -> Void {
        DispatchQueue.main.async {
//            self.imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
//            self.imagePicker.delegate = self
//            self.imagePicker.allowsEditing = true
//            self.imagePicker.videoQuality = .type640x480
//            self.imagePicker.videoMaximumDuration = 60
//            self.imagePicker.mediaTypes = [kUTTypeMovie as String] // Pass this value  // kUTTypeImage // kUTTypeMovie
            self.imagePicker.sourceType = .camera
            controller.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate Methods

extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imagePicker.dismiss(animated: true) {
            self.didCompletePicking?(picker, info)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.imagePicker.dismiss(animated: true) {
            self.didCompletePicking?(self.imagePicker, nil)
        }
        
    }
    
}
