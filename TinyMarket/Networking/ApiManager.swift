//
//  ApiManager.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//

import Foundation
class ApplogistService: BaseService {
    
    static var baseUrl : String {
        get {
            return "https://desolate-shelf-18786.herokuapp.com/"
        }
    }
    
    static func getList(success: @escaping (_ itemList: [ItemListModel]) -> Void, failure: @escaping (_ errorModel: ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "list"
        
        get(url: url, success: { (responseData) in
            
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel: [ItemListModel] = try decoder.decode([ItemListModel].self, from: baseResponse)
                success(responseModel)
            }
            catch {
                failure(ErrorModel.init(error: error))
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    static func sendData(success: @escaping (_ order: Order) -> Void, failure: @escaping (_ errorModel: ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "checkout"
        let data = createJson(itemList: TotalConfig.shared.itemList)!
        post(url: URL(string: url)!,parameters: data) { responseData in
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel: Order = try decoder.decode(Order.self, from: baseResponse)
                success(responseModel)
            }
            catch {
                failure(ErrorModel.init(error: error))
            }
        } failure: { err in
            failure(err)
        }

    }
    static func createJson(itemList:[ItemListModel]) -> Data?{
        
        var informations:[[String:Any]] = []
        
        for index in 0..<itemList.count {
            let dict = ["id":itemList[index].id ?? "","amount":itemList[index].amount] as [String : Any]
            informations.append(dict)
        }
        
        //Convert to json
        let body = try? JSONSerialization.data(withJSONObject: ["products":informations], options: [])
        return body
    }
    
}
