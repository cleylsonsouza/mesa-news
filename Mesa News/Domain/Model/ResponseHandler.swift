//
//  ResponseHandler.swift
//  Mesa News
//

import ObjectMapper

class ResponseHandler: NSObject {
    
    var code: String?
    var message: String?
    var errors: [Error] = []
    
    // MARK: - API error object
    class Error: NSObject, Mappable {
        
        var code: String?
        var field: String?
        var message: String?
        
        override init() {}
        
        required init?(map: Map) {}
        
        // MARK: - JSON Mapping
        func mapping(map: Map) {
            code            <- map["code"]
            field           <- map["field"]
            message         <- map["message"]
        }
    }
}
