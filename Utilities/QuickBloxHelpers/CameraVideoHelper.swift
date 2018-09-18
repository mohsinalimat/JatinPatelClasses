//
//  CameraVideoHelper.swift
//  JoySalesApp
//
//  Created by indianic on 16/04/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos
import MediaPlayer
import AVKit


class CameraVideoHelper: NSObject, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    static let sharedInstance = CameraVideoHelper()
    //MARK:- Properties
    var objVC : UIViewController?
    typealias completionBlock = (UIImage?, URL? , String?) -> Void
    var block : completionBlock?
    
    
    // MARK: - Show Action sheet
    // MARK: -
    
    func showCameraVideoActionSheeet(_ controller : UIViewController ,showVideo : Bool,completionHandler:@escaping completionBlock){
        
        DispatchQueue.main.async(execute: {
            
            UIAlertController.showActionsheetForImagePicker(controller: controller, completion: { (index, strTitle) in
                if index == 1 {
                    // "Capture Photo" selcted
                    self.openCamera(controller, isVideo: true , showVideoOption: showVideo)
                }
                    
                else if index == 0 {
                    
                    
                    // If user selected gallery
                    let imagePicker =   UIImagePickerController()
                    imagePicker.mediaTypes = [kUTTypeMovie as String , kUTTypeImage as String]
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.allowsEditing = true
                    imagePicker.isEditing = true
                    controller.present(imagePicker, animated: true, completion: nil)
                    
                }
            })
        })
        objVC = controller
        block = completionHandler
    }
    
    // perform Camera or Video action Methods
    fileprivate func presentImagePicker(_ imagePicker: UIImagePickerController, _ showVideoOption: Bool, _ isVideo: Bool, _ VC: UIViewController) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            imagePicker.mediaTypes = showVideoOption ? [kUTTypeMovie as String , kUTTypeImage as String] : [kUTTypeImage as String]
            //                imagePicker.mediaTypes = [kUTTypeMovie as String , kUTTypeImage as String]
            if isVideo {
                //Check photo library permission
                self.checkPhotoLibraryPermission(VC)
                //set quality of video for compress size
                imagePicker.videoQuality = .type640x480
                if #available(iOS 11.0, *) {
                    
                    imagePicker.videoExportPreset = AVAssetExportPreset640x480
                }
                imagePicker.videoMaximumDuration = TimeInterval(300.0)
                imagePicker.cameraCaptureMode = .video
                imagePicker.mediaTypes = [kUTTypeMovie as String ,  kUTTypeImage as String ]
            }
            
            VC.present(imagePicker, animated: true, completion: nil)
            
        } else {
            //            print("Denied access to \(cameraMediaType)")
            print("ALLOW_CAMERA_ACCESS_FROM_SETTINGS")
        }
        
    }
    
    func openCamera (_ VC : UIViewController , isVideo : Bool , showVideoOption : Bool) {
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        let imagePicker = UIImagePickerController()
        
        switch cameraAuthorizationStatus {
            
        case .denied:
            //display alert to open setting if camera permission is denied
            alertPromptToAllowCameraAccessViaSettings(controller: VC, strType: "Camera")
            
        case .authorized:
            
            presentImagePicker(imagePicker, showVideoOption, isVideo, VC)
            
        case .restricted:
            break
            
        case .notDetermined:
            
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                print("CAMERA_NOT_SUPPORTED")
                return
            }
            
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                
                if granted {
                    self.presentImagePicker(imagePicker, showVideoOption, isVideo, VC)
                }
                
            }
            
        }
    }
    
    
    //MARK:- Show Alert to Open settings Page
    func alertPromptToAllowCameraAccessViaSettings(controller : UIViewController, strType : String) {
        
        UIAlertController.showAlert(controller: controller, title: "\"\("APP_Name")\" Would Like To Access the \(strType)", message: "Please grant permission to use the \(strType).", style: .alert, cancelButton: "Cancel", distrutiveButton: nil, otherButtons: ["Settings"]) { (aInt, aStrMsg) in
            if aInt == 0 {
                if !UIApplicationOpenSettingsURLString.isEmpty {
                    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    //check if user has allowed for photo library permission
    func checkPhotoLibraryPermission(_ VC : UIViewController) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
        }
        else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
            alertPromptToAllowCameraAccessViaSettings(controller: VC, strType: "Photo Library")
        }
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    
                }else {
                    //show alert to allow access photo library
                    UIAlertController.showAlert(controller: VC, title: "Photo library access is required to record Video", completion: { (aInt, strMsg) in
                    })
                }
            })
        }
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    // MARK:
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            
            // Get the Original Image.
            guard var image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            
            // Check If editing was enabled or not. If it was enabled then get the editted image.
            if picker.allowsEditing {
                image = info[UIImagePickerControllerEditedImage] as? UIImage ?? image
            }
            
            // Convert the image to the Data.
            let data = UIImagePNGRepresentation(image)
            // data?.writeToFile(imagePath, atomically: true)
            
            // Create the Destination path for saving the image.
            let destinationUrl = URL.urlForNewTemporaryFile(ext:"jpg")
            
            do {
                // Write the image to the path created.
                try data?.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                
            } catch {
                
                // Catch exception here and act accordingly
                block?(nil , nil , "")
                
                return
                
            }
            
            // Call the completion block to pass the image and continue the further process of post.
            block?(image, nil , "image")
            
        } else if mediaType.isEqual(to: kUTTypeMovie as String) {
            
            
            if let videoURL = info[UIImagePickerControllerMediaURL] as? URL{
                let aVideoImage = self.getThumbnailImage(forUrl: videoURL)
                
                let avAsset = AVURLAsset(url: videoURL)
                let startDate = Date()
                let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPreset640x480)
                
                let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let myDocPath = NSURL(fileURLWithPath: docDir).appendingPathComponent("temp.mp4")?.absoluteString
                
                let docDir2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
                
                let filePath = docDir2.appendingPathComponent("rendered-Video.mp4")
                deleteFile(filePath!)
                
                if FileManager.default.fileExists(atPath: myDocPath!){
                    do{
                        try FileManager.default.removeItem(atPath: myDocPath!)
                    }catch let error{
                        print(error)
                    }
                }
                
                exportSession?.outputURL = filePath
                exportSession?.outputFileType = AVFileType.mp4
                exportSession?.shouldOptimizeForNetworkUse = true
                
                let start = CMTimeMakeWithSeconds(0.0, 0)
                let range = CMTimeRange(start: start, duration: avAsset.duration)
                exportSession?.timeRange = range
                
                exportSession!.exportAsynchronously{() -> Void in
                    switch exportSession!.status{
                    case .failed:
                        print("\(exportSession!.error!)")
                        self.block?(aVideoImage,nil, "video")
                    case .cancelled:
                        print("Export cancelled")
                        self.block?(aVideoImage,nil, "video")
                    case .completed:
                        let endDate = Date()
                        let time = endDate.timeIntervalSince(startDate)
                        print(time)
                        print("Successful")
                        print(exportSession?.outputURL ?? "")
                        self.block?(aVideoImage,exportSession?.outputURL , "video")
                    // return exportSession?.outputURL
                    default:
                        break
                    }
                    
                }
            }
        }
        
        objVC?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        objVC?.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- Get width and height for video
    func resolutionForVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: fabs(size.width), height: fabs(size.height))
    }
    
    
    //MARK:- Open video Controller
    //MARK:-
    func playVideo (_ controller : UIViewController , videoUrl : URL)
    {
        let player = AVPlayer(url: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        controller.present(playerViewController, animated: true)
        {
            DispatchQueue.main.async {
                playerViewController.player!.play()
            }
            
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        //set property to get thumbnail the way video has taken
        imageGenerator.appliesPreferredTrackTransform = true
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func deleteFile(_ filePath:URL) {
        guard FileManager.default.fileExists(atPath: filePath.path) else{
            return
        }
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
        }catch{
            fatalError("Unable to delete file: \(error) : \(#function).")
        }
    }
}

public extension URL {
    static public func urlForNewTemporaryFile(ext pathExtension: String) -> URL {
        let fileName = "\(NSUUID().uuidString).\(pathExtension)"
        let tempPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        return URL(fileURLWithPath: tempPath[0]).appendingPathComponent(fileName)
        
    }
}
