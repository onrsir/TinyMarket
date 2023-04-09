//
//  Services.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//

import UIKit
import Alamofire

public protocol BaseService {
    static var baseUrl : String {get}
}

extension BaseService {
    
    static func get(url:URLConvertible, parameters:Parameters?=nil, encoding:ParameterEncoding = URLEncoding.default, headers:HTTPHeaders? = nil, success:@escaping (_ responseData:Data?) -> Void, failure:@escaping (_ err:ErrorModel?) -> Void) -> Void{
        AF.request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers).responseData { (response) in
            switch response.result {
            case .success:
                let responseData : Data? = response.data
                success(responseData)
            case let .failure(error):
                failure(ErrorModel(error: error))
            }
        }
    }
    
    static func post(url:URL, parameters:Data? = nil, encoding:ParameterEncoding = JSONEncoding.default, headers:HTTPHeaders? = nil, success:@escaping (_ responseData:Data?) -> Void, failure:@escaping (_ err:ErrorModel?) -> Void) -> Void  {
        var request = URLRequest(url: url)
        request.method = .post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters

        AF.request(request).responseData { (response) in
            switch response.result {
            case .success:
                let responseData : Data? = response.data
                success(responseData)
            case let .failure(error):
                failure(ErrorModel(error: error))
            }
            
        }
    }
}
