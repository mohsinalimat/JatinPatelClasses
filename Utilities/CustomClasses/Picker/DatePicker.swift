//
//  DatePicker.swift
//  JoySalesApp
//
//  Created by indianic on 07/06/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

// Properties
//

typealias completionBlock = (String) -> Void
var block : completionBlock!
var datePicker = UIDatePicker()
var parentVC = UIViewController()
let kDateFormat = "dd/MM/yyyy"

class DatePicker: NSObject {

    /// Call this function to present date picker on textfield
    class func pickDate(txtField : UITextField, VC : UIViewController ,completion : @escaping completionBlock) {
        
        parentVC = VC
        txtField.tintColor = UIColor .clear
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        datePicker.backgroundColor = UIColor.white

        if !(txtField.text?.isEmpty)!{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = kDateFormat
            if let date = dateFormatter.date(from: txtField.text!){
                datePicker.setDate(date, animated: false)
            }
        }
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.hexString("#22A3C8")
        toolBar.tintColor =  .white
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DatePicker.doneClick))
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.normal)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.selected)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(DatePicker.cancelClick))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.normal)
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.init(name: "OpenSans-SemiBold", size: 15.0)!], for: UIControlState.selected)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtField.inputView = datePicker
        txtField.inputAccessoryView = toolBar
        block = completion
    }
    
    @objc class  func doneClick(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = kDateFormat
        let aString = dateFormatter.string(from: datePicker.date)
        
        block(aString)
        parentVC.view.endEditing(true)
    }
    
    @objc class  func cancelClick() {
        parentVC.view.endEditing(true)
    }
    
}
