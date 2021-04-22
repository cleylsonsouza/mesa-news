//
//  AlamofireService.swift
//  Mesa News
//

import Alamofire

protocol AlamofireService {
    
    func GET(urlString: String, headers: HTTPHeaders,
             completionHandler: @escaping (_ responseJSON: Data?,
                                           _ statusCode: Int?,
                                           _ success: Bool) -> Void)
    
    func POST(urlString: String, _ params: Parameters,
              completionHandler: @escaping (_ responseJSON: Data?,
                                            _ message: AnyObject?,
                                            _ success: Bool) -> Void)
    
    func POST(urlString: String, headers: HTTPHeaders, _ params: Parameters,
              completionHandler: @escaping (_ responseJSON: Data?,
                                            _ statusCode: Int?,
                                            _ success: Bool,
                                            _ headers: Alamofire.HTTPHeaders) -> Void)
}
