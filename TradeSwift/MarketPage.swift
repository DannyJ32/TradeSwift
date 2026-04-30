//
//  MarketPage.swift
//  TradeSwift
//
//  Created by Student on 4/29/26.
import SwiftUI

struct MarketPage: View {
    
    @State private var network = NetworkClient()
    @State private var userSymbol: String = "AAPL"
    
    var body: some View {
        NavigationStack {
            Text(network.rawJSON)
                .padding()
                .navigationTitle(userSymbol)
                .task {
                    network.rawJSON = await network.fetchQuote(symbol: userSymbol)
                }
        }
    }
}

#Preview {
    MarketPage()
}
