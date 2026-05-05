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
            VStack(alignment: .leading, spacing: 12) {
                if let q = network.quote {
                    Text("Current Price: $\(q.current, specifier: "%.2f")")
                    Text("Change: \(q.change, specifier: "%.2f")")
                        .foregroundStyle(q.change >= 0 ? .green : .red)
                    Text("Change %: \(q.percentChange, specifier: "%.2f")%")
                        .foregroundStyle(q.percentChange >= 0 ? .green : .red)
                    Text("Open: $\(q.oPrice, specifier: "%.2f")")
                    Text("High: $\(q.hPrice, specifier: "%.2f")")
                    Text("Low: $\(q.lPrice, specifier: "%.2f")")
                    Text("Prev Close: $\(q.pClose, specifier: "%.2f")")
                }
            }
            .padding()
            .navigationTitle(userSymbol)
            .task {
                await network.fetchQuote(symbol: userSymbol)
            }
        }
    }
}

#Preview {
    MarketPage()
}
