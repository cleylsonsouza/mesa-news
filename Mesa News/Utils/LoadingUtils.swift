//
//  LoadingUtil.swift
//  Mesa News
//

import UIKit

class LoadingUtils {
    
    var overlay : UIView?

    public func getOverlay(toView: UIView) -> UIView? {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.style = .large
        loadingIndicator.color = Colors.accent
        loadingIndicator.startAnimating()

        overlay = UIView(frame: toView.frame)
        overlay?.backgroundColor = UIColor.black
        overlay?.alpha = 0.6
        overlay?.addSubview(loadingIndicator)
        loadingIndicator.center = overlay!.center

        return overlay
    }
}
