//
//  LanguageUtility.swift
//  Localization
//
//  Created by ind563 on 4/25/17.
//  Copyright © 2017 JJ. All rights reserved.
//

import UIKit
enum LanguageCode: String {
    case English = "en"
    case ProtuguesBrazil = "pt-BR"
}

open class LanguageUtility: NSObject {
//test
    static let sharedInstance = LanguageUtility()
    
    func getLocalizedString(_ key :String) -> String? {
        
        let userDefaults = UserDefaults
        var languageCode = userDefaults.value(forKey: "AppLanguage") as? String
        userDefaults.synchronize()

        if languageCode == nil {
            languageCode = "en"
        }
        
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundleObj = Bundle.init(path: path!)
        
        let localizedStringValue = NSLocalizedString(key, tableName: "", bundle: bundleObj!, value: "", comment: "")
        return localizedStringValue
    }
    
    func setApplicationLanguage(_ languageCode : String){
        let userDefaults = UserDefaults
        userDefaults.set(languageCode, forKey: "AppLanguage")
        userDefaults.synchronize()
    }
    
    func getApplicationLanguage() -> String {
        
        if let languageCode = UserDefaults.value(forKey: "AppLanguage") as? String {
            return languageCode
        }
        return LanguageCode.English.rawValue
    }
    
    func getUppercasedApplicationLanguage() -> String {
        
        if let languageCode = UserDefaults.value(forKey: "AppLanguage") as? String {
            return languageCode.uppercased()
        }
        return LanguageCode.English.rawValue.uppercased()
    }
}
