//
//  BoolExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:39 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


// MARK: - Properties
public extension Bool {
    
    /// Return 1 if true, or 0 if false.
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// Return "true" if true, or "false" if false.
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    public var string: String {
        return description
    }
    
    /// Return inversed value of bool.
    ///
    ///        false.toggled -> true
    ///        true.toggled -> false
    ///
    public var toggled: Bool {
        return !self
    }
    
    /// Returns a random boolean value.
    ///
    ///     Bool.random -> true
    ///     Bool.random -> false
    ///
//    public static var random: Bool {
//        return arc4random_uniform(UInt32(2)) == UInt32(1)
//    }
    
}
