//
//  ExtensionUITextField.swift
//  StructureApp
//
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:39 AM - (indianic)
//
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//
//  


import Foundation
import UIKit

// TODO: - Delegate Issue

// MARK: - Extension of UITextField For UITextField's placeholder Color.
extension UITextField {
    
    /// Placeholder Color of UITextField , as it is @IBInspectable so you can directlly set placeholder color of UITextField From Interface Builder , No need to write any number of Lines.
    @IBInspectable var placeholderColor:UIColor?  {
        
        get  {
            return self.placeholderColor
        } set {
            
            if let newValue = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "" , attributes: [NSAttributedStringKey.foregroundColor:newValue])
            }
        }
    }
    
}

// MARK: - Extension of UITextField For Adding Left & Right View For UITextField.
extension UITextField {
    
    /// This method is used to add a leftView of UITextField.
    ///
    /// - Parameters:
    ///   - strImgName: String value - Pass the Image name.
    ///   - leftPadding: CGFloat value - (Optional - so you can pass nil if you don't want any spacing from left side) OR pass how much spacing you want from left side.
    func addLeftImageAsLeftView(strImgName:String? , leftPadding:CGFloat?) {
        
        let leftView = UIImageView(image: UIImage(named: strImgName ?? ""))
        
        leftView.frame = CGRect(x: 0.0, y: 0.0, width: (((leftView.image?.size.width) ?? 0.0) + (leftPadding ?? 0.0)), height: ((leftView.image?.size.height ?? 0.0)))
        
        leftView.contentMode = .center
        
        self.leftViewMode = .always
        self.leftView = leftView
    }
    
    /// This method is used to add a rightView of UITextField.
    ///
    /// - Parameters:
    ///   - strImgName: String value - Pass the Image name.
    ///   - rightPadding: CGFloat value - (Optional - so you can pass nil if you don't want any spacing from right side) OR pass how much spacing you want from right side.
    func addRightImageAsRightView(strImgName:String? , rightPadding:CGFloat?) {
        
        let rightView = UIImageView(image: UIImage(named: strImgName ?? ""))
        
        rightView.frame = CGRect(x: 0.0, y: 0.0, width: (((rightView.image?.size.width) ?? 0.0) + (rightPadding ?? 0.0)), height: ((rightView.image?.size.height ?? 0.0)))
        
        rightView.contentMode = .center
        
        self.rightViewMode = .always
        self.rightView = rightView
    }
    
}

typealias selectedDateCompletion = ((Date) -> ())

// MARK: - Extension of UITextField For DatePicker as UITextField's inputView.
extension UITextField : UITextFieldDelegate {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    private struct AssociatedObjectKey {
        
        static var txtFieldDatePicker = "txtFieldDatePicker"
        static var datePickerDateFormatter = "datePickerDateFormatter"
        static var selectedDateCompletion = "selectedDateCompletion"
        static var defaultDate = "defaultDate"
        static var isPrefilledDate = "isPrefilledDate"
    }
    
    /// A Computed Property of UIDatePicker , If its already in memory then return it OR not then create new one and store it in memory reference.
    private var txtFieldDatePicker:UIDatePicker? {
        
        get {
            
            if let txtFieldDatePicker = objc_getAssociatedObject(self, &AssociatedObjectKey.txtFieldDatePicker) as? UIDatePicker {
                
                return txtFieldDatePicker
                
            } else {
                return self.addDatePicker()
            }
            
        } set {
            
            if let txtFieldDatePicker = objc_getAssociatedObject(self, &AssociatedObjectKey.txtFieldDatePicker) as? UIDatePicker {
                
                objc_setAssociatedObject(self, &AssociatedObjectKey.txtFieldDatePicker, txtFieldDatePicker, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /// A Private method used to create a UIDatePicker and store it in a memory reference.
    ///
    /// - Returns: return a newly created UIDatePicker.
    private func addDatePicker() -> UIDatePicker {
        
        let txtFieldDatePicker = UIDatePicker()
        self.inputView = txtFieldDatePicker
        txtFieldDatePicker.addTarget(self, action: #selector(self.handleDateSelection(sender:)), for: .valueChanged)
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.txtFieldDatePicker, txtFieldDatePicker, .OBJC_ASSOCIATION_RETAIN)
        
        self.inputAccessoryView = self.addToolBar()
        self.tintColor = .clear
        
        return txtFieldDatePicker
    }
    
    /// A Computed Property of DateFormatter , If its already in memory then return it OR not then create new one and store it in memory reference.
    private var datePickerDateFormatter:DateFormatter? {
        
        get {
            
            if let datePickerDateFormatter = objc_getAssociatedObject(self, &AssociatedObjectKey.datePickerDateFormatter) as? DateFormatter {
                
                return datePickerDateFormatter
                
            } else {
                return self.addDatePickerDateFormatter()
            }
            
        } set {
            
            if let datePickerDateFormatter = objc_getAssociatedObject(self, &AssociatedObjectKey.datePickerDateFormatter) as? DateFormatter {
                
                objc_setAssociatedObject(self, &AssociatedObjectKey.datePickerDateFormatter, datePickerDateFormatter, .OBJC_ASSOCIATION_RETAIN)
            }
            
        }
        
    }
    
    /// A Private methos used to create a DateFormatter and store it in a memory reference.
    ///
    /// - Returns: return a newly created DateFormatter.
    private func addDatePickerDateFormatter() -> DateFormatter {
        
        let datePickerDateFormatter = DateFormatter()
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.datePickerDateFormatter, datePickerDateFormatter, .OBJC_ASSOCIATION_RETAIN)
        
        return datePickerDateFormatter
    }
    
    /// A Private method used to handle the date selection event everytime when value changes from UIDatePicker.
    ///
    /// - Parameter sender: UIDatePicker - helps to trach the selected date from UIDatePicker
    @objc private func handleDateSelection(sender:UIDatePicker) {
        
        self.text = self.datePickerDateFormatter?.string(from: sender.date)
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.defaultDate, sender.date, .OBJC_ASSOCIATION_RETAIN)
        
        if let selectedDateCompletion = objc_getAssociatedObject(self, &AssociatedObjectKey.selectedDateCompletion) as? selectedDateCompletion {
            
            if let stringDate = self.text {
                
                if let selectedDate = self.datePickerDateFormatter?.date(from: stringDate) {
                    
                    selectedDateCompletion(selectedDate)
                }
            }
        }
    }
    
    /// This method is used to set the UIDatePickerMode.
    ///
    /// - Parameter mode: Pass the value of Enum(UIDatePickerMode).
    func setDatePickerMode(mode:UIDatePickerMode) {
        self.txtFieldDatePicker?.datePickerMode = mode
    }
    
    /// This method is used to set the maximumDate of UIDatePicker.
    ///
    /// - Parameter maxDate: Pass the maximumDate you want to see in UIDatePicker.
    func setMaximumDate(maxDate:Date) {
        self.txtFieldDatePicker?.maximumDate = maxDate
    }
    
    /// This method is used to set the minimumDate of UIDatePicker.
    ///
    /// - Parameter minDate: Pass the minimumDate you want to see in UIDatePicker.
    func setMinimumDate(minDate:Date) {
        self.txtFieldDatePicker?.minimumDate = minDate
    }
    
    /// This method is used to set the (DateFormatter.Style).
    ///
    /// - Parameter dateStyle: Pass the value of Enum(DateFormatter.Style).
    func setDateFormatterStyle(dateStyle:DateFormatter.Style) {
        self.datePickerDateFormatter?.dateStyle = dateStyle
    }
    
    /// This method is used to enable the UIDatePicker into UITextField. Before using this method you can use another methods for set the UIDatePickerMode , maximumDate , minimumDate & dateFormat) , it will help you to see proper UIDatePickerMode , maximumDate , minimumDate etc into UIDatePicker.
    ///
    /// - Parameters:
    ///   - dateFormate: A String Value used to set the dateFormat you want.
    ///   - defaultDate: A Date? (optional - you can pass nil if you don't want any defualt value) Or pass proper date which will behave like it is already selected from UIDatePicker(you can see this date into UIDatePicker First when UIDatePicker present).
    ///   - isPrefilledDate: A Bool value will help you to prefilled the UITextField with Default Value when UIDatePicker Present.
    ///   - selectedDateCompletion: A Completion Block returns a selected date.
    func setDatePickerWithDateFormate(dateFormate:String , defaultDate:Date? , isPrefilledDate:Bool , selectedDateCompletion:selectedDateCompletion) {
        
        self.inputView = self.txtFieldDatePicker
        
        self.setDateFormate(dateFormat: dateFormate)
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.selectedDateCompletion, selectedDateCompletion, .OBJC_ASSOCIATION_RETAIN)
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.defaultDate, defaultDate, .OBJC_ASSOCIATION_RETAIN)
        
        objc_setAssociatedObject(self, &AssociatedObjectKey.isPrefilledDate, isPrefilledDate, .OBJC_ASSOCIATION_RETAIN)
        
        self.delegate = self
    }
    
    /// A Private method is used to set the dateFormat of UIDatePicker.
    ///
    /// - Parameter dateFormat: A String Value used to set the dateFormatof UIDatePicker.
    private func setDateFormate(dateFormat:String) {
        self.datePickerDateFormatter?.dateFormat = dateFormat
    }
    
    /// A Private method is used to add a UIToolbar above UIDatePicker. This UIToolbar contain only one UIBarButtonItem(Done).
    ///
    /// - Returns: return newly created UIToolbar
    private func addToolBar() -> UIToolbar {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 44.0))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let btnDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.btnDoneTapped(sender:)))
        
        toolBar.setItems([flexibleSpace , btnDone], animated: true)
        
        return toolBar
    }
    
    /// A Private method used to handle the touch event of button Done(A UIToolbar Button).
    ///
    /// - Parameter sender: UIBarButtonItem
    @objc private func btnDoneTapped(sender:UIBarButtonItem) {
        self.resignFirstResponder()
    }
    
    /// Delegate method of UITextFieldDelegate.
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let _ = self.inputView as? UIDatePicker {
            
            if let isPrefilledDate = objc_getAssociatedObject(self, &AssociatedObjectKey.isPrefilledDate) as? Bool {
                
                if isPrefilledDate {
                    
                    if let defaultDate = objc_getAssociatedObject(self, &AssociatedObjectKey.defaultDate) as? Date {
                        
                        self.txtFieldDatePicker?.date = defaultDate
                        
                        self.text = self.datePickerDateFormatter?.string(from: defaultDate)
                        
                    }
                }
            }
        }
        
        if let parentViewController = self.parentViewController {
            
            if parentViewController.canPerformAction(#selector(textFieldDidBeginEditing(_:)), withSender: self) {
                
                parentViewController.performSelector(inBackground: #selector(textFieldDidBeginEditing(_:)), with: self)
                
            }
        }
    }
}

extension UITextField {
    
    
    
}
