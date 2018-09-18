//
//  DoubleExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:45 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import CoreGraphics

// MARK: - Properties
public extension Double {
    
    /// Int.
    public var int: Int {
        return Int(self)
    }
    
    /// Float.
    public var float: Float {
        return Float(self)
    }
    
    /// CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
}
