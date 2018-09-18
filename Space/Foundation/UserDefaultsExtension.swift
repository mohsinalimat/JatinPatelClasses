//
//  UserDefaultsExtension.swift
//  EZSwiftExtensions
//
//  Created by Vinay on 12/1/15.
//  Copyright © 2015 Goktug Yilmaz. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    /// EZSE: Generic getter and setter for UserDefaults. 
    public subscript(key: String) -> AnyObject? {
        get {
            //return hasValue(forKey: key) as AnyObject?
            return object(forKey: key) as AnyObject?
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// SwifterSwift: Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float object for key (if exists).
    public func float(forKey key: String) -> Float? {
            return object(forKey: key) as? Float
    }
    
    /// SwifterSwift: Date from UserDefaults.
    ///
    /// - Parameter forKey: key to find date for.
    /// - Returns: Date object for key (if exists).
    public func date(forKey key: String) -> Date? {
            return object(forKey: key) as? Date
    }
    
    
    /// SwifterSwift: Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    public func object<T: Codable>(_ type: T.Type,
                                   with key: String,
                                   usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        
        return try? decoder.decode(type.self, from: data)
    }
    
    /// SwifterSwift: Allows storing of Codable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    public func set<T: Codable>(object: T,
                                forKey key: String,
                                usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        
        self.set(data, forKey: key)
    }
    
    /// SwifterSwift: Check key is available in UserDefaults.
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    

    /// SwifterSwift: Allows storing of Codable objects to UserDefaults.
    ///
    /// - Example:
    ///   - UserDefaults.standard.hasValue(forKey: "username")
    func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}

public extension UserDefaults {
    
    func setArchivedData(_ object: Any?, forKey key: String) {
        var data: Data?
        if let object = object {
            data = NSKeyedArchiver.archivedData(withRootObject: object)
        }
        set(data, forKey: key)
    }
    
    func unarchiveObjectWithData(forKey key: String) -> Any? {
        guard let object = object(forKey: key) else { return nil }
        guard let data = object as? Data else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
}




/* EXAMPLE */
/*
private struct TestObject: Codable {
    var id: Int
}

func testGetCodableObject() {
    let key = "codableTestKey"
    let codable: TestObject = TestObject(id: 1)
    UserDefaults.standard.set(object: codable, forKey: key)
    let retrievedCodable = UserDefaults.standard.object(TestObject.self, with: key)
    XCTAssertNotNil(retrievedCodable)
}

func testSetCodableObject() {
    let key = "codableTestKey"
    let codable: TestObject = TestObject(id: 1)
    UserDefaults.standard.set(object: codable, forKey: key)
    let retrievedCodable = UserDefaults.standard.object(TestObject.self, with: key)
    XCTAssertNotNil(retrievedCodable)
}*/


