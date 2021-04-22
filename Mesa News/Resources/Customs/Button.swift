//
//  Button.swift
//  Mesa News
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class CustomButton: MDCButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustomButton()
    }

    private func initCustomButton() {
        self.layer.cornerRadius =  8
        self.backgroundColor = Colors.primary
    }
}

class CustomOutlineButton: MDCButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomOutlineButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustomOutlineButton()
    }

    private func initCustomOutlineButton() {
        self.layer.cornerRadius =  8
        self.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0)
        self.setTitleColor(Colors.primary, for: .normal)
        self.setBorderColor(Colors.primary, for: .normal)
        self.setBorderWidth(1.0, for: .normal)
        self.inkColor = UIColor.lightGray
    }
}
