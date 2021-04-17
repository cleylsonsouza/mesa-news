//
//  News.swift
//  Mesa News
//

import ObjectMapper

class NewsFeed: NSObject, Mappable {
    
    var pagination: Pagination?
    var data: [FeedData] = []
    
    override init() {}
    
    required init?(map: Map) {}
    
    // MARK: - JSON Mapping
    func mapping(map: Map) {
        pagination      <- map["pagination"]
        data            <- map["data"]
    }
    
    class Pagination: NSObject, Mappable {
        
        var currentPage: Int?
        var perPage: Int?
        var totalPages: Int?
        var totalItems: Int?
        
        override init() {}
        
        required init?(map: Map) {}
        
        // MARK: - DATA JSON Mapping
        func mapping(map: Map) {
            currentPage     <- map["current_page"]
            perPage         <- map["per_page"]
            totalPages      <- map["total_pages"]
            totalItems      <- map["total_items"]
        }
    }
    
    class FeedData: NSObject, Mappable {
        
        var title: String?
        var newsDescription: String?
        var content: String?
        var author: String?
        var publishedAt: String?
        var highlight: Bool?
        var url: String?
        var imageUrl: String?
        
        override init() {}
        
        required init?(map: Map) {}
        
        // MARK: - DATA JSON Mapping
        func mapping(map: Map) {
            title               <- map["title"]
            newsDescription     <- map["description"]
            content             <- map["content"]
            author              <- map["author"]
            publishedAt         <- map["published_at"]
            highlight           <- map["highlight"]
            url                 <- map["url"]
            imageUrl            <- map["image_url"]
        }
    }
}

extension NewsFeed {
    
    public static func getFeedFrom(responseJSON: Data) -> NewsFeed {
        var object: NewsFeed = NewsFeed()
        do {
            if let jsonData = try JSONSerialization.jsonObject(with: responseJSON, options: JSONSerialization.ReadingOptions()) as? NSObject {
                let map = Mapper<NewsFeed>().map(JSONObject: jsonData)
                object = map!
            }
        } catch {
            print("JSON Error: \(error.localizedDescription))")
        }
        return object
    }
    
}
