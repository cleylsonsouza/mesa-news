//
//  SessionManager.swift
//  Mesa News
//

import Alamofire

class SessionManager {
    
    private static var SCHEME: String = "https://"
    
    private static var HOST: String = "mesa-news-api.herokuapp.com"
    private static var PATH: String = "\(SCHEME)\(HOST)"
    private static var API: String = "\(PATH)/v1/client"
    
    //MARK: - Authentication
    static var SIGN_IN: String = "\(API)/auth/signin"
    static var SIGN_UP: String = "\(API)/auth/signup"
    
    //MARK: - News
    static var NEWS_FEED: String = "\(API)/news?current_page=%@&per_page=%@&published_at=%@"
    static var HIGHLIGHTS: String = "\(API)/news/highlights"
    
    static var TEST_TOKEN: String = "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MjU5LCJlbWFpbCI6ImRpbWFzLmdhYnJpZWxAenJvYmFuay5jb20uYnIifQ.a3j7sRx8FIedZCfDGLocduOYpcibfIenX7TVJjv6Sis"

    struct APIManager {
        static let sessionManager: Alamofire.Session = {
            let configuration = URLSessionConfiguration.default
            var headers = configuration.headers
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"
            return Alamofire.Session(
                configuration: configuration
            )
        }()
        
    }
    
    public static func getSession()-> Alamofire.Session {
        return APIManager.sessionManager
    }
}
