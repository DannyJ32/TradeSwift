//
//  MarketPage.swift
//  TradeSwift
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct MarketPage: View {
    
    var function: String
    var keyword: String
    var apiKey: String = "438WDN2DSDKQHPXM"
    
    @State private var result: String = "Loading"

    var body: some View {
        let urlStr = "https://www.alphavantage.co/query?function=\(function)&keywords=\(keyword)&apikey=\(apiKey)"

        Text(result)
            .task {
                guard let url = URL(string: urlStr) else { return }
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    result = String(data: data, encoding: .utf8) ?? "No data"
                } catch let error {
                    print(error)
                }
            }
    }
}

#Preview {
    MarketPage(function: "SYMBOL_SEARCH", keyword: "apple")
}
