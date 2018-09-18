//
//  String+Localization.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 3:03 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit

extension String {
    
    /// This will get the Localization String from the string file based on the current language
    ///
    ///        "Your String".localized -> "Localized string from the file" // second week in the current year.
    ///
    public var localized: String {
        
        // Set your Application Langugage here. You can set your custom logic here to get the language code string.
        var strLang : String? = "en"
        
        // Check for the default Language
        if strLang == nil {
            strLang = "en"
        }
        
        // Get the Path for the String file based on language selction
        guard let path = MAIN_BUNDLE.path(forResource: strLang, ofType: "lproj") else {
            return self
        }
        
        // Get the Bundle Path
        let langBundle = Bundle(path: path)
        
        // Get the Local String for Key and return it
        return langBundle?.localizedString(forKey: self, value: "", table: nil) ?? self
        
    }
    
}
