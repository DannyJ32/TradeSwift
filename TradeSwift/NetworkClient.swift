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
    var rawJSON: String = "Loading..."
    
    func fetchQuote(symbol: String) async -> String {
        let urlStr = "https://finnhub.io/api/v1/quote?symbol=\(symbol)&token=\(apiKey)"
        guard let url = URL(string: urlStr) else { return "Bad URL" }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(data: data, encoding: .utf8) ?? "No data"
        } catch {
            return "Error: \(error.localizedDescription)"
        }
    }
}
