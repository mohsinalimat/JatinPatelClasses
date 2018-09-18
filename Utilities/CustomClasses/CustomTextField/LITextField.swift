//
//  LITextField.swift
//  
//
//  Created by indianic on 19/01/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

class LITextField: UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    func initialSetup() {
        self.isUserInteractionEnabled = true
        self.borderColor = UIColor.clear
        self.borderWidth = 1.0
        self.cornerRadius = 8.0
        self.tintColor = UIColor.hexString("#22A3C8")
        self.leftView = paddingView
        self.leftViewMode = .always
        self.font = UIFont.init(name: "OpenSans-SemiBold", size: 17.0)
        self.textColor = UIColor.hexString("#4A4A4A")
    }

    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        layer.customBorderColor = UIColor.hexString("#22A3C8")
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        layer.borderWidth = 1
        super.becomeFirstResponder()
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        layer.customBorderColor = UIColor.clear
        super.resignFirstResponder()
        
        return true
    }
}

extension CALayer {
    var customBorderColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: self.borderColor!)
        }
    }
}

extension UITextView{
    
    func setTextViewTheme(){
        
        self.borderColor = UIColor.gray
        self.borderWidth = 1.0
        self.cornerRadius = 5.0
        self.tintColor = UIColor.hexString("#22A3C8")

    }
}
