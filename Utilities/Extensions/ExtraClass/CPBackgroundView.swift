//
//  BackgroundView.swift
//  Lowda
//
//  Created by indianic on 29/11/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class CPBackgroundView: UIView {

    @IBInspectable var viewHeightMode : Int  = 0
    var view:UIView!
    func setup() {
        self.backgroundColor = UIColor.colorFromCode(0xF8F8F8)
        if viewHeightMode == 1 {
            view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height:165))
            
        } else {
            view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height:165))
        }
        view.backgroundColor = UIColor.colorFromCode(0xF22F46)
        self.addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.setup()
    }
    
    override func draw(_ rect: CGRect) {
        
        
        //setup()
        
    }

    override func awakeFromNib() {
        setup()
    }
}
