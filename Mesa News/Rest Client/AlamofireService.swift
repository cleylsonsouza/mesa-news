//
//  AlamofireService.swift
//  Mesa News
//

import Alamofire

protocol AlamofireService {
    
    func GET(url: String, headers: HTTPHeaders, completionHandler: @escaping (_ responseJSON: Data?, _ statusCode: Int?, _ success: Bool) -> Void) -> Void
    
    func POST(url: String, _ params: Parameters, completionHandler: @escaping (_ responseJSON: Data?, _ message: AnyObject?, _ success: Bool) -> Void) -> Void
    
    func POST(url: String, headers: HTTPHeaders, _ params: Parameters, completionHandler: @escaping (_ responseJSON: Data?, _ statusCode: Int?, _ success: Bool, _ headers: Alamofire.HTTPHeaders) -> Void) -> Void
    
    func PUT(url: String, headers: HTTPHeaders, _ params: Parameters, completionHandler: @escaping (_ responseJSON: Data?, _ statusCode: Int?, _ success: Bool, _ headers: Alamofire.HTTPHeaders) -> Void) -> Void
    
    func PATCH(url: String, _ params: Parameters, completionHandler: @escaping (_ responseJSON: Data?, _ message: AnyObject?, _ success: Bool) -> Void) -> Void
    
    func DELETE(url: String, headers: HTTPHeaders, completionHandler: @escaping (_ responseJSON: Data?, _ message: AnyObject?, _ success: Bool) -> Void) -> Void
    
    func DELETE(url: String, headers: HTTPHeaders, completionHandler: @escaping (_ responseJSON: Data?, _ statusCode: Int?, _ success: Bool, _ headers: Alamofire.HTTPHeaders) -> Void) -> Void
}
