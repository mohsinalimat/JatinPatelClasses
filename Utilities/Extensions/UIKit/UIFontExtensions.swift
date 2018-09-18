//
//  UIFontExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:26 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit


extension UIFont {
    
    // HOW TO USE : UIFont.MuliRegular(16.0)
    
    private class func fontWithName(name : String, Size : CGFloat ) -> UIFont {
        return UIFont(name: name, size: Size)!
    }
    
    /// Use this method to get **Muli** font
    /// ## Usage Example: ##
    /// ````
    /// UIFont.MuliRegular(size: 16.0)
    /// ````
    ///
    /// - Parameter size: Size of the Font
    /// - Returns: **Muli** font with specified size
    class func MuliRegular(size : CGFloat) -> UIFont {
        return self.fontWithName(name: "Muli", Size: size)
    }
    
    /// Use this method to get **Muli-Bold** font
    /// ## Usage Example: ##
    /// ````
    /// UIFont.MuliBold(size: 16.0)
    /// ````
    ///
    /// - Parameter size: Size of the Font
    /// - Returns: **Muli-Bold** font with specified size
    class func MuliBold(size : CGFloat) -> UIFont {
        return self.fontWithName(name: "Muli-Bold", Size: size)
    }
    
    /// Use this method to get **Muli-Light** font
    /// ## Usage Example: ##
    /// ````
    /// UIFont.MuliLight(size: 16.0)
    /// ````
    ///
    /// - Parameter size: Size of the Font
    /// - Returns: **Muli-Light** font with specified size
    class func MuliLight(size : CGFloat) -> UIFont {
        return self.fontWithName(name: "Muli-Light", Size: size)
    }
    
    /// Use this method to get **Muli-SemiBold** font
    /// ## Usage Example: ##
    /// ````
    /// UIFont.MuliSemiBold(size: 16.0)
    /// ````
    ///
    /// - Parameter size: Size of the Font
    /// - Returns: **Muli-SemiBold** font with specified size
    class func MuliSemiBold(size : CGFloat) -> UIFont {
        return self.fontWithName(name: "Muli-SemiBold", Size: size)
    }
    
}
