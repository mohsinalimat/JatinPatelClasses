//
//  UILabelExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:29 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit

// MARK: - Methods
public extension UILabel {
    
    /// Initialize a UILabel with text
    public convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    /// Required height for a label
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }

    var numberOfVisibleLines: Int {
            let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
            let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
            let charSize: Int = lroundf(Float(self.font.pointSize))
            return rHeight / charSize
        }
    
}
