//
//  StringExtension.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 3:20 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit

extension String {
    
    /// Convert String to date
    func stringToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your date format
        let date = dateFormatter.date(from: self) //according to date format your date string
        print(date ?? "") //Convert String to Date
        return date
    }
    
    /// Remove Whitespace from string.
    public var trimWhitespace: String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    
    /// String with no spaces or new lines in beginning and end.
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// String decoded from base64  (if applicable).
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }
    
    /// String encoded in base64 (if applicable).
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = self.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// This method will replace the string with other string.
    ///
    /// - Parameters:
    ///   - string: String which you wanted to replace.
    ///   - withString: String by which you want to replace 1st string.
    /// - Returns: Returns new string by replacing string
    public func replace(string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString)
    }
    
    /// Array with unicodes for all characters in a string.
    public var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
    
    /// Readable string from a URL string.
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// URL escaped string.
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Bool value from string (if applicable).
    public var bool: Bool? {
        let selfLowercased = self.trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" || selfLowercased == "yes" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" || selfLowercased == "no" {
            return false
        } else {
            return nil
        }
    }
    
    /// Double value from string (if applicable).
    public var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    /// Float value from string (if applicable).
    public var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    /// Float32 value from string (if applicable).
    public var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    /// Float64 value from string (if applicable).
    public var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    /// Integer value from string (if applicable).
    public var int: Int? {
        return Int(self)
    }
    
    /// Int16 value from string (if applicable).
    public var int16: Int16? {
        return Int16(self)
    }
    
    /// Int32 value from string (if applicable).
    public var int32: Int32? {
        return Int32(self)
    }
    
    /// Int64 value from string (if applicable).
    public var int64: Int64? {
        return Int64(self)
    }
    
    /// Int8 value from string (if applicable).
    public var int8: Int8? {
        return Int8(self)
    }
    
    /// URL from string (if applicable).
    public var url: URL? {
        return URL(string: self)
    }
    
    /// First character of string (if applicable).
    public var firstCharacter: String? {
        guard let aFirst = self.first else {
            return nil
        }
        return String(aFirst)
    }
    
    /// Last character of string (if applicable).
    public var lastCharacter: String? {
        guard let aLast = self.last else {
            return nil
        }
        return String(aLast)
    }
    
    /// This will remove all the other Characters except the numbers.
    public var removeExceptDigits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
}



//extension String {
//
//    /// This will return the MD5 string of the string which is used to call this property. To use this add #import <CommonCrypto/CommonCrypto.h> in your header file
//    public var MD5: String {
//        get{
//            let messageData = self.data(using:.utf8)!
//            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//
//            _ = digestData.withUnsafeMutableBytes {digestBytes in
//                messageData.withUnsafeBytes {messageBytes in
//                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//                }
//            }
//
//            return digestData.map { String(format: "%02hhx", $0) }.joined()
//        }
//    }
//
//}

