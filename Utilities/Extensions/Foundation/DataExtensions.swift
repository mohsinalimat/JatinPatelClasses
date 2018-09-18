//
//  DataExtensions.swift
//  StructureApp
// 
//  Created By: Kushal Panchal, IndiaNIC Infotech Ltd
//  Created on: 15/11/17 12:03 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation

// MARK: - Properties
public extension Data {
    
    /// Return data as an array of bytes.
    public var bytes: [UInt8] {
        //http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }
}

// MARK: - Methods
public extension Data {
    
    /// String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    public func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
}
