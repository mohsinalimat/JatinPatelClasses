//
//  String+Validation.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 3:16 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit

extension String {
    
    /// Check if string contains one or more letters.
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Check if string contains one or more numbers.
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Check if string contains only letters.
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    /// Check if string contains at least one letter and one number.
    public var isAlphaNumeric: Bool {
        return components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    /// Check if string contains only numbers.
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Check if string is valid Email address or not.
    public var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    /// Check if string starts with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    /// Check if string ends with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// Check if string contains one or more instance of substring.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contain(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// Check if string is https URL.
    public var isHttpsUrl: Bool {
        guard start(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Check if string is http URL.
    public var isHttpUrl: Bool {
        guard start(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    var isAlphanumeric : Bool {
        
        return range(of: "^[a-zA-Z0-9\\s]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    var isAlphabetsAndSpaces : Bool {
        return range(of: "^[a-zA-Z\\s]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    var isPhoneNumber : Bool {
        return range(of: "^[0-9]{6,14}$", options: .regularExpression, range: nil, locale: nil) != nil
        
    }
    var isNumber : Bool {
        return range(of: "^([0-9]*|[0-9]*[.][0-9]*)$", options: .regularExpression, range: nil, locale: nil) != nil
        
    }
//    var isEmail : Bool {
//        return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .regularExpression, range: nil, locale: nil) != nil
//
//    }
    var isZipCode : Bool {
        return range(of: "^(0[289][0-9]{2})|([1345689][0-9]{3})|(2[0-8][0-9]{2})|(290[0-9])|(291[0-4])|(7[0-4][0-9]{2})|(7[8-9][0-9]{2})$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func isEmptyString() -> Bool {
        let _ : Array<String> = []
        let tempText = self.trimmingCharacters(in: CharacterSet.whitespaces)
        if tempText.isEmpty {
            return true
        }
        return false
    }
    
    func validatePassword() -> Bool {
  
        let regExPattern = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[@#$%*]).{8,}$"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", regExPattern)
        
        let boolValidator = passwordValid.evaluate(with: self)
        
        return boolValidator
    }
    
//    func isValidPassword() -> Bool
//    {
//        let emailRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
//        
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        
//        return emailTest.evaluate(with: self)
//        
//    }
    
    func validateMinimumLength(_ minimumLength : NSInteger) -> Bool {
        
        let strValue = self.removeWhiteSpace()
        
        if (strValue.count < minimumLength) {
            return false
        }
        
        return true
    }
    
    func validateMaximumLength(_ maximumLength : NSInteger) -> Bool {
        
        let strValue = self.removeWhiteSpace()
        
        if (strValue.count > maximumLength) {
            return false
        }
        
        return true
        
    }
    
    
    /**
     Method will remove white Space from String
     
     - returns: New String after removing White space from existing String.
     */
    func removeWhiteSpace() -> String {
        let strValue = self.trimmingCharacters(in: NSMutableCharacterSet.whitespaceAndNewline() as CharacterSet)
        return strValue
    }
    
    /**
     Method will remove extra white Space from String
     
     For Ex. : "This is     the demo    text  remove    extra  space   between the   words."
     Output  : "This is the demo text remove extra space between the words."
     
     - returns: New String after removing White space from existing String.
     */
    
    func removeExtraSpace() -> String {
        var stringValue: String = String(self[self.startIndex])
        for (index,value) in self.enumerated(){
            if index > 0 {
                let indexBefore = self.index(before: String.Index.init(encodedOffset: index))
                if value == " " && self[indexBefore] == " " {
                } else {
                    stringValue.append(value)
                }
            }
        }
        return stringValue
    }
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    
}
extension UnicodeScalar {
    
    var isEmoji: Bool {
        
        switch value {
        case 0x3030, 0x00AE, 0x00A9, // Special Characters
        0x1D000 ... 0x1F77F, // Emoticons
        0x2100 ... 0x27BF, // Misc symbols and Dingbats
        0xFE00 ... 0xFE0F, // Variation Selectors
        0x1F900 ... 0x1F9FF: // Supplemental Symbols and Pictographs
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        
        return value == 8205
    }
}

extension String {
    
    var glyphCount: Int {
        
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        
        return !unicodeScalars.filter { $0.isEmoji }.isEmpty
    }
    
    var containsOnlyEmoji: Bool {
        
        return unicodeScalars.first(where: { !$0.isEmoji && !$0.isZeroWidthJoiner }) == nil
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            
            if let prev = previousScalar, !prev.isZeroWidthJoiner && !scalar.isZeroWidthJoiner {
                
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map{ String($0) } .reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
    
}

