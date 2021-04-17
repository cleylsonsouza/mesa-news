//
//  UIStoryboardExtension.swift
//  Mesa News
//

import UIKit

extension UIStoryboard {
    
    // MARK: USER storyboard
    static func buildSignInViewController() -> UIViewController {
        return userStoryboard.instantiateViewController(withIdentifier: "signin")
    }
    
    static func buildSignUpViewController() -> UIViewController {
        return userStoryboard.instantiateViewController(withIdentifier: "signup")
    }
    
    // MARK: FEED storyboard
    static func buildNewsViewController() -> UIViewController {
        return newsStoryboard.instantiateViewController(withIdentifier: "news_navigation")
    }
}

extension UIStoryboard {
    
    static var userStoryboard : UIStoryboard {
        return getStoryboard(name: "User")
    }
    
    static var newsStoryboard : UIStoryboard {
        return getStoryboard(name: "News")
    }
}

extension UIStoryboard {
    static func getStoryboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
