//
//  HomePageViewModel.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import Foundation
protocol HomePageVMMDelegate: AnyObject {
    func getListResponse(itemList:[ItemListModel])
    func getErr(err:ErrorModel)
}

class HomePageViewModel {
    var delegate: HomePageVMMDelegate?
    func getListReq() {
        ApplogistService.getList(success: { itemList in
            self.delegate?.getListResponse(itemList: itemList)
        }, failure: { errorModel in
            guard let errorModel = errorModel else {
                return
            }
            self.delegate?.getErr(err: errorModel)
        })
    }
}
