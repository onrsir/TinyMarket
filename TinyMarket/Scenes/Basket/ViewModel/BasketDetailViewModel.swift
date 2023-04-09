//
//  BasketDetailViewModel.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import Foundation
import UIKit
protocol BasketDetailViewModelDelegate: AnyObject {
    func getOrderResponse(order:Order)
    func getErr(err:ErrorModel?)
}

class BasketDetailViewModel {
    var delegate: BasketDetailViewModelDelegate?
    func getList() {
        ApplogistService.sendData { order in
            self.delegate?.getOrderResponse(order: order)
        } failure: { errorModel in
            self.delegate?.getErr(err: errorModel)
            
        }

    }
}
