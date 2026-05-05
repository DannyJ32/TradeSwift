//
//  Stock.swift
//  TradeSwift
//
//  Created by Student on 5/1/26.
//

import Foundation

import Foundation

struct StockQuote: Codable {
    let current: Double
    let change: Double
    let percentChange: Double
    let hPrice: Double
    let lPrice: Double
    let oPrice: Double
    let pClose: Double
    let t: Double
    
    enum CodingKeys: String, CodingKey {
        case current = "c"
        case change = "d"
        case percentChange = "dp"
        case hPrice = "h"
        case lPrice = "l"
        case oPrice = "o"
        case pClose = "pc"
        case t
    }
}
