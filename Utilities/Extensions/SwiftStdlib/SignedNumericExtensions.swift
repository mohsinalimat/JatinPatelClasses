//
//  SignedNumericExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:48 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation

// MARK: - Properties
public extension SignedNumeric {
    
    /// String.
    public var string: String {
        return String(describing: self)
    }
    
    /// String with number and current locale currency.
    public var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        guard let number = self as? NSNumber else { return "" }
        return formatter.string(from: number) ?? ""
    }
}
