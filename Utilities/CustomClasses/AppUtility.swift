    //
//  AppUtility.swift
//  Lowda
//
//  Created by indianic on 07/12/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
    import SystemConfiguration
    import MobileCoreServices
    import Photos
    import MessageUI
    import Alamofire
    import SwiftyJSON
    
    class AppUtility: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate, CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
        
        // MARK:singleton sharedInstance
        static let sharedInstance = AppUtility()
        
        
        
        
        //Camera Picker
        typealias kOpenCameraCallBackBlock = (_ selectedImage : UIImage?) ->Void
        
        var cameraCallBackBlock :kOpenCameraCallBackBlock?
        
        var cameraController : UIViewController?
        var mailController : UIViewController?
        
        // Location
        public typealias kCurrentLocationHandler = (_ manager : CLLocationManager,_ location : CLLocation?,_ error :Error?) -> Void
        
        var currentLocationCallBlock : kCurrentLocationHandler?
        var locationManager: CLLocationManager!
        
        
       
        func openPickerWithCamera(_ isopenCamera:Bool) {
            
            let captureImg = UIImagePickerController()
            captureImg.delegate = self
            if(isopenCamera){
                captureImg.sourceType = UIImagePickerControllerSourceType.camera
            }else{
                captureImg.sourceType = UIImagePickerControllerSourceType.photoLibrary
            }
            captureImg.mediaTypes = [kUTTypeImage as String]
            captureImg.allowsEditing = true
            cameraController?.present(captureImg, animated: true, completion: nil)
        }
        
        
        // MARK: - UIImagePicker Controller Delegate
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
            
            if let img = info[UIImagePickerControllerEditedImage] as? UIImage{
                
                if (cameraCallBackBlock != nil){
                    
                    cameraCallBackBlock!(UIImage(data: img.mediumQualityJPEGNSData))
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            
            if (cameraCallBackBlock != nil){
                
                cameraCallBackBlock!(nil)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        
        func getDateFromString(_ date : String , dateFormat : String) -> Date {
            
            let dateFormatter  = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.date(from: date)!
        }
        
        func getStringFromDate(_ format : String , date : Date) -> String {
            
            let dateFormatter  = DateFormatter()
            dateFormatter.dateFormat = format
            //                dateFormatter.timeZone = TimeZone(identifier: "UTC")
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            return dateFormatter.string(from: date)
        }
        // MARK: -----------------
        // MARK: UIPicker
        // MARK: -----------------
        
        
        typealias pickerCompletionBlock = (_ picker:AnyObject?, _ buttonIndex : Int,_ firstindex:Int) ->Void
        var pickerType :String?
        var datePicker : UIDatePicker?
        var simplePicker : UIPickerView?
        var pickerDataSource : NSMutableArray?
        var pickerBlock : pickerCompletionBlock?
        var pickerSelectedIndex :Int = 0
        
        
        func addPicker(_ controller:UIViewController,onTextField:UITextField,typePicker:String,pickerArray:[String],minimumDate:Date,maximumDate:Date, showMinDate : Bool = false,withCompletionBlock:@escaping pickerCompletionBlock) {
            
            pickerType = typePicker
            onTextField.tintColor = UIColor.clear
            
            let keyboardDateToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: controller.view.bounds.size.width, height: 50))
            keyboardDateToolbar.barTintColor = UIColor.colorFromCode(0xE67B02)
            
            
            let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let done = UIBarButtonItem.init(title: "Done", style: .done, target: self, action:  #selector(pickerDone))
            done.tintColor = UIColor.white
            
            let cancel = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action:  #selector(pickerCancel))
            cancel.tintColor = UIColor.white
            
            keyboardDateToolbar.setItems([cancel,flexSpace,done], animated: true)
            onTextField.inputAccessoryView = keyboardDateToolbar
            
            if typePicker == "Date" {
                
                datePicker = UIDatePicker.init()
                datePicker!.backgroundColor = UIColor.white
                datePicker!.datePickerMode = .dateAndTime
                datePicker!.maximumDate = maximumDate
                datePicker!.minimumDate = minimumDate
                
                
                
                let dateFormatter = DateFormatter.init()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm a"
                if let date = dateFormatter.date(from: onTextField.text!)
                {
                    datePicker?.date = date
                }
                onTextField.inputView = datePicker
                
            } else if typePicker == "Time" {
                
                datePicker = UIDatePicker.init()
                datePicker!.backgroundColor = UIColor.white
                datePicker!.datePickerMode = .time
                if showMinDate {
                    datePicker!.minimumDate = Date()
                }
                datePicker!.date = Date()
                
                onTextField.inputView = datePicker
                
            }else {
                
                pickerDataSource = NSMutableArray.init(array: pickerArray)
                simplePicker = UIPickerView.init()
                simplePicker!.backgroundColor = UIColor.white
                simplePicker!.delegate = self
                simplePicker!.dataSource = self
                
                if let index = pickerArray.index(of: onTextField.text!) {
                    simplePicker!.selectRow(index, inComponent: 0, animated: true)
                }
                onTextField.inputView = simplePicker
            }
            
            pickerBlock = withCompletionBlock
        }
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if (pickerDataSource != nil) {
                return pickerDataSource!.count
            }
            return 0
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerDataSource![row] as? String
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            
            pickerSelectedIndex = row
        }
        
        @objc func pickerDone()
        {
            print(pickerBlock!)
            if pickerType == "Date" {
                
                pickerBlock!(datePicker!,1,0)
            } else if pickerType == "Time"  {
                pickerBlock!(datePicker!,1,0)
            } else {
                pickerBlock!(simplePicker!,1,pickerSelectedIndex)
            }
        }
        
        @objc func pickerCancel()
        {
            pickerBlock!(nil,0,0)
        }
        
        func getTimeComponentFomDateString(_ receivedDate: String) -> String{
            
            let calendar = Calendar.current as Calendar
            
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            dateFormatter.dateFormat = yyyyMMddTHHmmss
            //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            let aDate = Date()
            let timeStamp = dateFormatter.string(from: aDate)
            
            
//            guard let date11 = dateFormatter.date(from: receivedDate) else { return "" }
            
            guard let date11 = dateFormatter.date(from: receivedDate) else { return "" }
            
            guard let date22 = dateFormatter.date(from: timeStamp) else { return "" }
            
            
            var flags = Set<Calendar.Component>([.year])
            var components = calendar.dateComponents(flags, from: date11, to: date22)
            
            if components.year! > 0 {
                var aTime = ""
                if components.year! == 1{
                    aTime = "\(components.year!) year ago"
                }
                else {
                    aTime = "\(components.year!) years ago"
                }
                return aTime as String
            }
            
            flags =  Set<Calendar.Component>([.month])
            components = calendar.dateComponents(flags, from: date11, to: date22)
            
            if components.month! > 0 {
                var aTime = ""
                if components.month! == 1{
                    aTime = "\(components.month!) month ago"
                }
                else {
                    aTime = "\(components.month!) months ago"
                }
                return aTime as String
            }
            
            
            flags =  Set<Calendar.Component>([.day])
            components = calendar.dateComponents(flags, from: date11, to: date22)
            
            
            if components.day! > 0 {
                var aTime = ""
                if components.day! == 1{
                    aTime = "\(components.day!) day ago"
                }
                else {
                    aTime = "\(components.day!) days ago"
                }
                return aTime as String
                
            }
            
            flags =  Set<Calendar.Component>([.hour])
            components = calendar.dateComponents(flags, from: date11, to: date22)
            
            if components.hour! > 0 {
                var aTime = ""
                if components.hour! == 1{
                    aTime = "\(components.hour!) hr ago"
                }
                else {
                    aTime = "\(components.hour!) hrs ago"
                }
                return aTime as String
            }
            
            flags =  Set<Calendar.Component>([.minute])
            components = calendar.dateComponents(flags, from: date11, to: date22)
            
            if components.minute! > 0 {
                var aTime = ""
                if components.minute! == 1 {
                    aTime = "\(components.minute!) min ago"
                }
                else
                {
                    aTime = "\(components.minute!) mins ago"
                }
                
                return aTime
                
                // let aTime = "\(components.minute!) minutes"
                // return aTime as String as NSString
            }
            
            flags =  Set<Calendar.Component>([.second])
            components = calendar.dateComponents(flags, from: date11, to: date22)
            
            if components.second! > 0 {
                var aTime = ""
                if components.second! == 1 {
                    aTime = "\(components.second!) sec ago"
                }
                else
                {
                    aTime = "\(components.second!) secs ago"
                }
                
                return aTime
                
                // let aTime = "\(components.second!) seconds"
                // return aTime as String as NSString
            }
            
            let aTime = "0 sec ago"
            return aTime
        }
        
        // MARK: -----------------
        // MARK: CLLocationManager Methods
        // MARK: -----------------
        
        func getUserCurrentLocation(completionHandler : @escaping kCurrentLocationHandler) {
            
            self.currentLocationCallBlock = completionHandler
            locationManager = CLLocationManager()
            
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
            
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            manager.stopUpdatingLocation()
            let currentLocation = locations[0] as CLLocation
            
            print("user latitude = \(currentLocation.coordinate.latitude)")
            print("user longitude = \(currentLocation.coordinate.longitude)")
            
            self.currentLocationCallBlock!(manager,currentLocation,nil)
            
            
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
        {
            self.currentLocationCallBlock!(manager,nil,error)
            print("Error \(error)")
        }
        
        class func convertObjectToJson(from object: Any) -> String? {
            if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
                let objectString = String(data: objectData, encoding: .utf8)
                return objectString
            }
            return nil
        }
        
       class func convertToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
        
        func base64Encoded(text:String) -> String {
            
            let textViewData = text.data(using: .nonLossyASCII)
            let valueUniCode = String.init(data: textViewData!, encoding: .utf8)!
            return valueUniCode
        }
        
        func base64Decoded(text:String) -> String {
            
            let emojData   = text.data(using: .utf8)
            let emojString = String.init(data: emojData!, encoding: .nonLossyASCII)
            return emojString!
        }
        
       
        
        
        func flag(country:String) -> String {
            let base : UInt32 = 127397
            var s = ""
            for v in country.unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
        
    }
