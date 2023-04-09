//
//  Cart.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//

import Foundation

// MARK: - ItemListModel
class ItemListModel: Hashable, Codable {
    static func == (lhs: ItemListModel, rhs: ItemListModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    let id: String?
    let name: String?
    let price: Double?
    let currency: String?
    let imageUrl: String?
    let stock: Int?
    var amount = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case currency = "currency"
        case imageUrl = "imageUrl"
        case stock = "stock"
    }
    
    init(id: String?, name: String?, price: Double?, currency: String?, imageUrl: String?, stock: Int?) {
        self.id = id
        self.name = name
        self.price = price
        self.currency = currency
        self.imageUrl = imageUrl
        self.stock = stock
    }
}
