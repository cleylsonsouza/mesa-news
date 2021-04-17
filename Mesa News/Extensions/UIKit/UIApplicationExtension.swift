//
//  UIApplicationExtension.swift
//  Mesa News
//

import UIKit

extension UIApplication {
    
    func setStatusBarWith(view: UIView, backgroundColor: UIColor) {
        if #available(iOS 13.0, *) {
            let statusBarHeight: CGFloat = {
                var heightToReturn: CGFloat = 0.0
                     for window in self.windows {
                         if let height = window.windowScene?.statusBarManager?.statusBarFrame.height, height > heightToReturn {
                                 heightToReturn = height
                             }
                     }
                return heightToReturn
            }()
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = backgroundColor
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = backgroundColor
        }
    }
}
