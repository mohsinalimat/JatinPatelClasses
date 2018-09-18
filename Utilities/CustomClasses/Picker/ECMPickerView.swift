//
//  ECMPicker.swift
//  OneECMApp
//
//  Created by indianic on 23/02/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

class ECMPickerDataModel {
    
    // MARK: Properties
    
    var name: String
    var nameAr: String
    var id : String
    
    init?(_ name: String,_ nameAr: String,_ id: String) {
        
        self.name = name
        self.nameAr = nameAr
        self.id = id
    }
    
}

class ECMPickerView: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
     // MARK : Properties
     // MARK:
    
    static let sharedInstance = ECMPickerView()
    typealias pickerCompletionBlock = (_ selectedIndex:Int , _ selectedValue : String) ->Void
    var simplePicker : UIPickerView?
    var pickerDataSource : NSMutableArray?
    var pickerBlock : pickerCompletionBlock?
    var pickerSelectedIndex :Int = 0
    var parentVC = UIViewController()
    var arrPickerData = [String]()

    var arrCategoryData = [ECMPickerDataModel]()
    var arrSubCategoryData = [ECMPickerDataModel]()
    var arrPriorityData = [ECMPickerDataModel]()
    var arrDeliveryModeData = [ECMPickerDataModel]()
    
    /// Call this function to add picker over textfield
    func addPicker(_ controller:UIViewController,onTextField:UITextField,pickerArray:[String],withCompletionBlock:@escaping pickerCompletionBlock) {
       
        parentVC = controller
        arrPickerData = pickerArray
        onTextField.tintColor = UIColor.clear
        
        let keyboardDateToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: controller.view.bounds.size.width, height: 44))
        keyboardDateToolbar.barTintColor = UIColor.hexString("#22A3C8")
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem.init(title:"Done".localized, style: .done, target: self, action:  #selector(pickerDone))
        done.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.normal)
        done.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.highlighted)
        done.tintColor = UIColor.white
        
        let cancel = UIBarButtonItem.init(title:"Cancel".localized, style: .done, target: self, action:  #selector(pickerCancel))
        cancel.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.normal)
        cancel.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.highlighted)
        cancel.tintColor = UIColor.white
        
        keyboardDateToolbar.setItems([cancel,flexSpace,done], animated: true)
        onTextField.inputAccessoryView = keyboardDateToolbar
        
        pickerDataSource = NSMutableArray.init(array: pickerArray)
        simplePicker = UIPickerView.init()
        simplePicker!.backgroundColor = UIColor.white
        simplePicker!.delegate = self
        simplePicker!.dataSource = self
        
        if let index = pickerArray.index(of: onTextField.text!) {
            simplePicker!.selectRow(index, inComponent: 0, animated: true)
        }
        onTextField.inputView = simplePicker
        pickerBlock = withCompletionBlock
    }
    
    // MARK: UIPickerView Delegates
    // MARK:
    
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
    
    // MARK: Button Click Events
    // MARK:

    @objc func pickerDone() {
        pickerBlock!(pickerSelectedIndex , arrPickerData[pickerSelectedIndex])
        parentVC.view.endEditing(true)
    }
    
    @objc func pickerCancel() {
        parentVC.view.endEditing(true)
    }
}
