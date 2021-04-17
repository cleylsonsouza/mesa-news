//
//  TextField.swift
//  Mesa News
//

import MaterialComponents

private var __maxLengths = [MDCTextField: Int]()

class CustomOutlinedTextField: MDCTextField {
    
    var textController: MDCTextInputControllerOutlined!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = UIColor.white
        self.textColor = Colors.text
        
        textController = MDCTextInputControllerOutlined(textInput: self)
        textController.activeColor = Colors.text
        textController.normalColor = Colors.primary
        textController.floatingPlaceholderActiveColor = Colors.text
        textController.floatingPlaceholderNormalColor = Colors.primary
        textController.inlinePlaceholderColor = Colors.primary
        textController.borderRadius = 8
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: MDCTextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}
