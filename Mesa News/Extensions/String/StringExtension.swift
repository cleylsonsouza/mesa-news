//
//  StringExtension.swift
//  Mesa News
//

extension String {
    
    func safelyLimitedTo(length: Int) -> String {
        let text = self
        if (text.count <= length) { return self }
        return String( Array(text).prefix(upTo: length) )
    }
}
