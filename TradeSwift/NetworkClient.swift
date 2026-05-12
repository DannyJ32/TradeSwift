//
//  NetworkClient.swift
//  TradeSwift
//
//  Created by Student on 5/1/26.
//

import Foundation
import SwiftUI

@Observable
class NetworkClient {
    
    let apiKey = "d7sde89r01qorsviadkgd7sde89r01qorsviadl0"
    var quote: StockQuote? = nil
    
    func fetchQuote(symbol: String) async {
        let urlStr = "https://finnhub.io/api/v1/quote?symbol=\(symbol)&token=\(apiKey)"
        guard let url = URL(string: urlStr) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            quote = try JSONDecoder().decode(StockQuote.self, from: data)
        } catch {
            print(error)
        }
    }
}

@Observable
class StockDetailViewModel {
    var quote: StockQuote?
    private let network = NetworkClient()

    func load(symbol: String, preloaded: StockQuote?) {
        if let preloaded {
            quote = preloaded
        } else {
            Task {
                await network.fetchQuote(symbol: symbol)
                quote = network.quote
            }
        }
    }
}
