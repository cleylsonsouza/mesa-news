//
//  StringExtension.swift
//  Mesa News
//

extension String {
    
    func safelyLimitedTo(length n: Int)->String {
        let c = self
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}
