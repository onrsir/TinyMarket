//
//  TotalConfig.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//

import Foundation
class TotalConfig {
    static let shared = TotalConfig()
    var itemList: [ItemListModel] = []
    var totalAmount:Double {
        var total : Double = 0.0
        for item in itemList {
            total += (item.price ?? 0.0)*Double(item.amount)
        }
        return total.rounded(toPlaces: 2)
    }
    
    var totalProduct:Int {
        var total: Int = 0
        for item in itemList {
            total += item.amount
        }
        return total
    }
}
