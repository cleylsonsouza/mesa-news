//
//  BaseView.swift
//  Mesa News
//

import Foundation
import Foundation
import UIKit

@objc protocol BaseViewProtocol: NSObjectProtocol {
    @objc optional func showAlert(title: String, message: String)
    @objc optional func showAlertWith(action: ((UIAlertAction) -> Void)?, title: String, message: String)
    @objc func loading(show: Bool)
    @objc optional func dismissKeyboard()
    @objc optional func configureViewComponents()
}
