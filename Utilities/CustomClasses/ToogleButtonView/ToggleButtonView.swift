//
//  ToggleButtonView.swift
//  LoveInternational
//
//  Created by indianic on 17/07/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

class ToggleButtonView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnNo: UIButton!
    
   @IBInspectable var isBtnSelected:Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        load()
    }
    
    @IBAction func btnYesClicked(_ sender: UIButton) {
        if !isBtnSelected {
            btnYes.backgroundColor = UIColor.hexString("#22A3C8")
            btnNo.backgroundColor = UIColor.clear
            btnYes.setTitleColor(UIColor.white, for: .normal)
            btnNo.setTitleColor(UIColor.darkGray, for: .normal)
            isBtnSelected = true
        }
    }
    
    @IBAction func btnNoClicked(_ sender: UIButton) {
        if isBtnSelected {
            btnNo.backgroundColor = UIColor.hexString("#22A3C8")
            btnYes.backgroundColor = UIColor.clear
            btnNo.setTitleColor(UIColor.white, for: .normal)
            btnYes.setTitleColor(UIColor.darkGray, for: .normal)
            isBtnSelected = false
        }
    }
    
    public func load(){
        Bundle.main.loadNibNamed("ToggleButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        if !isBtnSelected {
            btnNo.backgroundColor = UIColor.hexString("#22A3C8")
            btnYes.backgroundColor = UIColor.clear
            btnNo.setTitleColor(UIColor.white, for: .normal)
            btnYes.setTitleColor(UIColor.darkGray, for: .normal)
            isBtnSelected = false
        } else {
            btnYes.backgroundColor = UIColor.hexString("#22A3C8")
            btnNo.backgroundColor = UIColor.clear
            btnYes.setTitleColor(UIColor.white, for: .normal)
            btnNo.setTitleColor(UIColor.darkGray, for: .normal)
            isBtnSelected = true
        }
    }
}
