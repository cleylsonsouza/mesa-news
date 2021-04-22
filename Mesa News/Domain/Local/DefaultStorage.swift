//
//  DefaultStorage.swift
//  Mesa News
//

import Foundation

class DefaultStorage {
    
    static let defaults = UserDefaults.standard
    
    static func archiveDataWith(object : AnyObject, key: String) {
        do {
            let encodedObject = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            defaults.set(encodedObject, forKey: key)
            defaults.synchronize()
        } catch let signOutError as NSError {
            print("Error archiving data", signOutError.localizedDescription)
        }
    }
    
    static func unarchiveObjectFor(key : String) -> AnyObject? {
        if let objectData = defaults.object(forKey: key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObject(with: objectData as Data) as AnyObject?
        }
        
        return nil
    }
    
    static func clearDefaultsStorageForKey(key: String) {
        defaults.set(nil, forKey: key)
    }
    
    static func add(key: String, value: AnyObject) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    static func get(key: String) -> String {
        if let value = defaults.object(forKey: key) as? String {
            return value
        }
        return ""
    }
    
}
