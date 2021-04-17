//
//  UserStorage.swift
//  Mesa News
//

import Foundation

class UserStorage: DefaultStorage {
    
    private static let sessionKey = "user_session"
    
    static var user: User? {
        get {
            return unarchiveObjectFor(key: sessionKey) as? User
        }
        set {
            archiveDataWith(object: newValue!, key: sessionKey)
        }
    }
    
    static func clearSession() {
        clearDefaultsStorageForKey(key: sessionKey)
    }
    
}
