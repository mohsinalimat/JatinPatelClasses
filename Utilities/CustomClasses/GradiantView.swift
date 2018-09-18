//
//  GradiantView.swift
//  LoveInternational
//
//  Created by indianic on 01/08/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit

class GradiantView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
    }
    
    override func layoutSubviews() {
        load()
    }
    private func load() {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: self.layer.frame.origin.x, y: self.layer.frame.origin.y, width: self.layer.frame.size.width, height: self.layer.frame.size.height)
        
        gradient.colors = [
            UIColor(red:0, green:0.5, blue:0.64, alpha:1).cgColor,
            UIColor(red:0.94, green:0.18, blue:0.58, alpha:1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 0.94)
        gradient.endPoint = CGPoint(x: 0.02, y: 0)
        self.layer.addSublayer(gradient)
        
    }
    
}
