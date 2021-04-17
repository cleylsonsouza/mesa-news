//
//  User.swift
//  Mesa News
//

import ObjectMapper

struct UserKey {
    static let nameKey = "name_key"
    static let emailKey = "email_key"
    static let tokenKey = "token_key"
}

class User: ResponseHandler, NSCoding, Mappable {
    
    var name: String = ""
    var email: String = ""
    var accessToken: String = ""
    
    override init() {}
    
    required init?(map: Map) {}
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.decoding(aDecoder: aDecoder)
    }
    
    // MARK: - JSON Mapping
    func mapping(map: Map) {
        name            <- map["name"]
        email           <- map["email"]
        accessToken     <- map["token"]
        
        code            <- map["code"]
        message         <- map["message"]
        errors          <- map["errors"]
    }
    
    // MARK: - Encoding/Decoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: UserKey.nameKey)
        aCoder.encode(self.email, forKey: UserKey.emailKey)
        aCoder.encode(self.accessToken, forKey: UserKey.tokenKey)
    }
    
    func decoding(aDecoder : NSCoder) {
        let sName: String = (aDecoder.decodeObject(forKey: UserKey.nameKey) as? String)!
        let sEmail: String = (aDecoder.decodeObject(forKey: UserKey.emailKey) as? String)!
        let sToken: String = (aDecoder.decodeObject(forKey: UserKey.tokenKey) as? String)!
        
        self.name = sName
        self.email = sEmail
        self.accessToken = sToken
    }
}

extension User {
    
    public static func getUserFrom(responseJSON: Data) -> User? {
        var object: User?
        do {
            if let jsonData = try JSONSerialization.jsonObject(with: responseJSON, options: JSONSerialization.ReadingOptions()) as? NSObject {
                let map = Mapper<User>().map(JSONObject: jsonData)
                object = map
            }
        } catch {
            print("JSON Error: \(error.localizedDescription))")
        }
        return object
    }
}
