//
//  AppConstants.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 13/11/17 10:46 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation


public extension UserDefaults {
    
    // MARK: - UserDefaults keys used in the application
    
    enum Keys {
        
        /// Key for User Login
        /// ````
        /// UserDefaults.Keys.userLogin
        /// ````
        static let userLogin                            = "IS_USER_LOGIN"
        
        /// Key for Application Language
        /// ````
        /// UserDefaults.Keys.appLanguage
        /// ````
        static let appLanguage                          = "APP_LANGUAGE"
        
        static let userDetails                          = "USER_DETAIL"
    }
    
    
    
}
