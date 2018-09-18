//
//  CustomTextField.swift
//  Quickee
//
//  Created by indianic on 12/12/17.
//  Copyright © 2017 Quickee. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    //Set LeftPadding of text-field
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.size.height))
            self.leftView = view
            self.leftViewMode = .always
        }
    }

    //Set RughtPadding of text-field
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.size.height))
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
    
        get{
           return self.placeHolderColor
        }
        set{
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
