//
//  RestClient.swift
//  Mesa News
//

import Alamofire

class RestClient: AlamofireService {
    
    func GET(urlString: String, headers: HTTPHeaders, completionHandler: @escaping (Data?, Int? , Bool) -> Void) {
        SessionManager.getSession().request(urlString, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode,true)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode,false)
            }
        }
    }
    
    func POST(urlString: String, _ params: Parameters, completionHandler: @escaping (Data?, AnyObject?, Bool) -> Void) {
        SessionManager.getSession().request(urlString, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, "" as AnyObject, true)
            case .failure( _):
                completionHandler(response.data, response.error.debugDescription as AnyObject, false)
            }
        }
    }
    
    func POST(urlString: String, headers: HTTPHeaders, _ params: Parameters, completionHandler: @escaping (Data?, Int?, Bool, Alamofire.HTTPHeaders) -> Void) {
        SessionManager.getSession().request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.data, response.response?.statusCode, true, response.response!.headers)
            case .failure( _):
                completionHandler(response.data, response.response?.statusCode, false, response.response!.headers)
            }
        }
    }
}
