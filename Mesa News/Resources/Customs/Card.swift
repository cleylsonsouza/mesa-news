//
//  Card.swift
//  Mesa News
//

import MaterialComponents

class CustomUnselectableCard: MDCCard {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isInteractable = false
        self.backgroundColor = UIColor.white
        self.setShadowElevation(ShadowElevation(rawValue: 2), for: .normal)
        self.setShadowColor(UIColor.gray, for: .normal)
        self.cornerRadius = 8
    }
}
