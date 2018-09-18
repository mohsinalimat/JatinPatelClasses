//
//  IntExtensions.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:46 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import CoreGraphics

// MARK: - Properties
public extension Int {
    
    /// CountableRange 0..<Int.
    public var countableRange: CountableRange<Int> {
        return 0..<self
    }
    
    /// Radian value of degree input.
    public var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }
    
    /// Degree value of radian input
    public var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }
    
    /// UInt.
    public var uInt: UInt {
        return UInt(self)
    }
    
    /// Double.
    public var double: Double {
        return Double(self)
    }
    
    /// Float.
    public var float: Float {
        return Float(self)
    }
    
    /// CGFloat.
    public var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    /// String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
    public var kFormatted: String {
        var sign: String {
            return self >= 0 ? "" : "-"
        }
        let abs = Swift.abs(self)
        if abs == 0 {
            return "0k"
        } else if abs >= 0 && abs < 1000 {
            return "0k"
        } else if abs >= 1000 && abs < 1000000 {
            return String(format: "\(sign)%ik", abs / 1000)
        }
        return String(format: "\(sign)%ikk", abs / 100000)
    }
    
}

// MARK: - Methods
public extension Int {
    
    /// Random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    /// - Returns: random double between two double values.
    public static func random(between min: Int, and max: Int) -> Int {
        return random(inRange: min...max)
    }
    
    /// Random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    /// - Returns: random double in the given closed range.
    public static func random(inRange range: ClosedRange<Int>) -> Int {
        let delta = UInt32(range.upperBound - range.lowerBound + 1)
        return range.lowerBound + Int(arc4random_uniform(delta))
    }
    
    /// check if given integer prime or not.
    /// Warning: Using big numbers can be computationally expensive!
    /// - Returns: true or false depending on prime-ness
    public func isPrime() -> Bool {
        guard self > 1 || self % 2 == 0 else {
            return false
        }
        // To improve speed on latter loop :)
        if self == 2 {
            return true
        }
        // Explanation: It is enough to check numbers until
        // the square root of that number. If you go up from N by one,
        // other multiplier will go 1 down to get similar result
        // (integer-wise operation) such way increases speed of operation
        let base = Int(sqrt(Double(self)) + 1)
        for i in Swift.stride(from: 3, to: base, by: 2) where self % i == 0 {
            return false
        }
        return true
    }
    
    /// Roman numeral string from integer (if applicable).
    ///
    ///        10.romanNumeral() -> "X"
    ///
    /// - Returns: The roman numeral string.
    public func romanNumeral() -> String? {
        // https://gist.github.com/kumo/a8e1cb1f4b7cff1548c7
        guard self > 0 else { // there is no roman numerals for 0 or negative numbers
            return nil
        }
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = self
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            if div > 0 {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        return romanValue
    }
    
}

// MARK: - Initializers
public extension Int {
    
    /// Created a random integer between two integer values.
    ///
    /// - Parameters:
    ///   - min: minimum number to start random from.
    ///   - max: maximum number random number end before.
    public init(randomBetween min: Int, and max: Int) {
        self = Int.random(between: min, and: max)
    }
    
    /// Create a random integer in a closed interval range.
    ///
    /// - Parameter range: closed interval range.
    public init(randomInRange range: ClosedRange<Int>) {
        self = Int.random(inRange: range)
    }
    
}

