//
//  RestClient.swift
//  Mesa News
//

import Alamofire

class RestClient: AlamofireService {
    
    func GET(url: String, headers: HTTPHeaders, completionHandler: @escaping (Data?, Int? , Bool) -> Void) {
        SessionManager.getSession().request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode,true)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode,false)
            }
        }
    }
    
    func POST(url: String, _ params: Parameters, completionHandler: @escaping (Data?, AnyObject?, Bool) -> Void) {
        SessionManager.getSession().request(url, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, "" as AnyObject, true)
            case .failure( _):
                completionHandler(response.data, response.error.debugDescription as AnyObject, false)
            }
        }
    }
    
    func POST(url: String, headers: HTTPHeaders, _ params: Parameters, completionHandler: @escaping (Data?, Int?, Bool, Alamofire.HTTPHeaders) -> Void) {
        SessionManager.getSession().request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode, true, response.response!.headers)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode, false, response.response!.headers)
            }
        }
    }
    
    func PUT(url: String, headers: HTTPHeaders, _ params: Parameters, completionHandler: @escaping (Data?, Int?, Bool, Alamofire.HTTPHeaders) -> Void) {
        SessionManager.getSession().request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode, true, response.response!.headers)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode, false, response.response!.headers)
            }
        }
    }
    
    func PATCH(url: String, _ params: Parameters, completionHandler: @escaping (Data?, AnyObject?, Bool) -> Void) {
        SessionManager.getSession().request(url, method: .patch, parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, "" as AnyObject, true)
            case .failure( _):
                completionHandler(response.data, response.error.debugDescription as AnyObject, false)
            }
        }
    }
    
    func DELETE(url: String, headers: HTTPHeaders, completionHandler: @escaping (Data?, AnyObject?, Bool) -> Void) {
        SessionManager.getSession().request(url, method: .delete, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, "" as AnyObject, true)
            case .failure( _):
                completionHandler(response.data, response.error.debugDescription as AnyObject, false)
            }
        }
    }
    
    func DELETE(url: String, headers: HTTPHeaders, completionHandler: @escaping (Data?, Int?, Bool, HTTPHeaders) -> Void) {
        SessionManager.getSession().request(url, method: .delete, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode, true, response.response!.headers)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode, false, response.response!.headers)
            }
        }
    }
}
