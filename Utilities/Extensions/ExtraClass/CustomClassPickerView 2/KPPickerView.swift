//
//  KPPickerView.swift
//  KPPickerView
// 
//  Created By: Kushal Panchal, IndiaNIC Infotech Ltd
//  Created on: 08/12/17 12:07 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit


class KPPickerView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK: - Default Configuration
    
    /// Default Configurations for PickerView
    public struct Config {
        
        public var btnDoneTitle = "Done"
        
        public var contentBackgroundColor: UIColor = UIColor.yellow
        public var footerBackgroundColor: UIColor = UIColor.green
        
        public var btnDoneColor: UIColor = UIColor.white
        
    }
    
    // MARK: - Public Properties
    
    /// Object of Confuguration which you can use to modify the UI
    public var config = Config()
    
    
    // MARK: - Private Properties
    
    /// Block for the Done button click. This will have the Selected Object and Selected Index from the picker view.
    typealias pickerViewDoneButtonClick = (_ selectedObject: Any , _ objectIndex: Int) -> Void
    
    /// Object of the Picker Done button click block. This block will be called when user tap on the Done button.
    fileprivate var pickerBlock : pickerViewDoneButtonClick?
    
    /// This object will store the selected object Index from the picker view.
    var selectedIndex: Int = 0
    
    /// This is the object of the PopOverViewController which will present on the source view with having UIPickerView in it.
    fileprivate var objPopOverController : UIViewController?
    
    /// This will store the data which is used to load in the Picker View.
    fileprivate var arrPickerData: [String] = [String]()
    
    
    
    // MARK: - Init Methods
    
    /// This method will get the view from the Nib.
    ///
    /// - Returns: Object of the class from NIB file
    static func getInstanceFromNib() -> KPPickerView {
        return UINib(nibName: String(describing: self), bundle: Bundle.main).instantiate(withOwner: self, options: nil).last as! KPPickerView
    }
    
    // MARK: - Private Method
   
    /// This method will Configure the default UI based on the user's configurations.
    private func setDefaultSettingsForPickerView() {
        
        // Load configurations
        
        btnDone.setTitle(config.btnDoneTitle, for: UIControlState())
        btnDone.setTitleColor(config.btnDoneColor, for: UIControlState())
        
        headerView.backgroundColor = config.footerBackgroundColor
        backgroundView.backgroundColor = config.contentBackgroundColor
        
    }
    
    
    /// This method will display PopOver Controller on the screen.
    ///
    /// - Parameters:
    ///   - parentVC: Object of Controller on which you wanted to display PopOver
    ///   - sender: Object of the Button/Label/TextField from which you wanted to display PopOver
    private func show(_ parentVC: UIViewController , sender: UIView, size: CGSize? = nil) {
        
        // Create Default Configuarations for the Picker View.
        setDefaultSettingsForPickerView()
        
        // Check for the PopOver Controller object and if it is nil then create a new one.
        if objPopOverController == nil {
            objPopOverController = UIViewController()
        }
        
        // Assign the View to the PopOver Controller's view.
        objPopOverController!.view = self
        
        // Define your content Size here.
        objPopOverController!.preferredContentSize = size ?? CGSize(width: min(bounds.size.width, UIScreen.main.bounds.width - 60.0), height: bounds.size.height)
        
        // Set Presentation style to PopOver.
        objPopOverController!.modalPresentationStyle = .popover
        
        // Create object of the UIPopoverPresentationController and set the default configurations.
        let aPopOverController: UIPopoverPresentationController = objPopOverController!.popoverPresentationController!
        aPopOverController.permittedArrowDirections = .any
        aPopOverController.delegate = self
        
        // Assign the Source view and frame.
        aPopOverController.sourceView = sender.superview
        aPopOverController.sourceRect = sender.frame
        
        // Present the Controller from the Source Controller which is passed.
        parentVC.present(objPopOverController!, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Button Click Methods
    
    /// This method will get called when user tap on the Done button and also it will dismiss the picker view and you will get the call back with selected index and selected data.
    ///
    /// - Parameter sender: Object of the Button.
    @IBAction func btnDoneClick(_ sender: UIButton) {
        
        let aSelectedValue = arrPickerData[selectedIndex]
        
        pickerBlock?(aSelectedValue, selectedIndex)
        
        if (objPopOverController != nil) {
            objPopOverController!.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - Public Methods
    
    
    /// This method will display Picker view inside the PopOver controller.
    ///
    ///
    ///
    ///
    /// - Parameters:
    ///   - parentVC: Object of Controller on which you wanted to display PopOver
    ///   - sender: Object of the Button/Label/TextField from which you wanted to display PopOver
    ///   - data: Array of data which will be displayed inside the Picker View
    ///   - defaultSelected: Default selected value which you wanted to display when Picker is displayed on the screen.
    ///   - withCompletionBlock: CompletionBlock with Selected object and Index.
    public func show(_ parentVC: UIViewController , sender: UIView, data: [String] , defaultSelected: String?, size: CGSize? = nil, withCompletionBlock: @escaping pickerViewDoneButtonClick) {
        
        // Store the data to the local array variable
        arrPickerData = data
        
        // Assign the Block to local variable
        pickerBlock = withCompletionBlock
        
        // Show the picker view
        show(parentVC, sender: sender, size: size)
        
        // Set your default selected value here.
        if let strDefault = defaultSelected {
            if let index = arrPickerData.index(of: strDefault) {
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }
        
    }
    
}

// MARK: - UIPickerViewDataSource Methods
extension KPPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPickerData.count
    }
    
}

// MARK: - UIPickerViewDelegate Methods
extension KPPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate Method
extension KPPickerView: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
