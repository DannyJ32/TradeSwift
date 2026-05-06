//
//  StockDetailView.swift
//  TradeSwift
//
//  Created by Student on 5/6/26.
//

import SwiftUI

struct StockDetailView: View {
    let symbol: String
    let name: String
    let quote: StockQuote?

    var body: some View {
        ZStack {
            Color(white: 0.15).ignoresSafeArea()
            
            VStack(spacing: 20) {
                
            }
        }
        .navigationTitle(symbol)
        .navigationBarTitleDisplayMode(.inline)
    }
}


// These are test values btw
#Preview {
    NavigationStack {
        StockDetailView(
            symbol: "AAPL",
            name: "Apple Inc.",
            quote: StockQuote(
                current: 185.92,
                change: 1.25,
                percentChange: 0.68,
                hPrice: 184.20,
                lPrice: 186.40,
                oPrice: 183.50,
                pClose: 184.67,
                t: 1.023
            )
        )
    }
}
