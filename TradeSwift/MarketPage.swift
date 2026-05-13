//
//  MarketPage.swift
//  TradeSwift
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct MarketPage: View {
    @State private var network = NetworkClient()
    @State private var searchText: String = ""
    @State private var quotes: [String: StockQuote] = [:]
    @State private var watchlist: [(symbol: String, name: String)] = [
        ("AAPL", "Apple"),
        ("NVDA", "NVIDIA"),
        ("TSLA", "Tesla"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(white: 0.15).ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("Markets")
                            .font(.largeTitle).bold()
                            .foregroundStyle(.white)
                        
                        Text(Date.now.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day()))
                            .foregroundStyle(.gray)
                        
                        Text("WATCHLIST")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.top, 8)
                        
                        if watchlist.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "star.slash")
                                    .font(.largeTitle)
                                    .foregroundStyle(.gray)
                                Text("Your watchlist is empty")
                                    .foregroundStyle(.gray)
                                Text("Search for a symbol above to add one")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        } else {
                            ForEach(watchlist, id: \.symbol) { stock in
                                NavigationLink(destination: StockDetailView(symbol: stock.symbol, name: stock.name, quote: quotes[stock.symbol])) {
                                    TickerRow(symbol: stock.symbol, name: stock.name, quote: quotes[stock.symbol])
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        watchlist.removeAll { $0.symbol == stock.symbol }
                                        quotes.removeValue(forKey: stock.symbol)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                Divider().overlay(Color.gray.opacity(0.5))
                            }
                        }
                    }
                    .padding()
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search symbol")
            .onSubmit(of: .search) {
                let symbol = searchText.uppercased().trimmingCharacters(in: .whitespaces)
                if symbol.isEmpty {
                    print("Nil value")
                    return
                }
                
                if !watchlist.contains(where: { $0.symbol == symbol }) {
                    watchlist.append((symbol, symbol))
                    Task {
                        await network.fetchQuote(symbol: symbol)
                        if let q = network.quote {
                            quotes[symbol] = q
                        }
                    }
                }
                searchText = ""
            }
            .task {
                for stock in watchlist {
                    await network.fetchQuote(symbol: stock.symbol)
                    if let q = network.quote {
                        quotes[stock.symbol] = q
                    }
                }
            }
        }
    }
}

struct TickerRow: View {
    let symbol: String
    let name: String
    let quote: StockQuote?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(symbol)
                    .font(.headline).bold()
                    .foregroundStyle(.white)
                Text(name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            if let q = quote {
                Text("$\(q.current, specifier: "%.2f")")
                    .foregroundStyle(.white)
                    .bold()
                
                Text("\(q.percentChange >= 0 ? "+" : "")\(q.percentChange, specifier: "%.1f")%")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(q.percentChange >= 0 ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                    .foregroundStyle(q.percentChange >= 0 ? .green : .red)
                    .cornerRadius(6)
            } else {
                ProgressView()
                    .tint(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MarketPage()
}

//@ViewBuilder
//private func displayStock() -> some View {
//    if let q = network.quote {
//        Text("Current Price: $\(q.current, specifier: "%.2f")")
//        Text("Change: \(q.change, specifier: "%.2f")")
//            .foregroundStyle(q.change >= 0 ? .green : .red)
//        Text("Change %: \(q.percentChange, specifier: "%.2f")%")
//            .foregroundStyle(q.percentChange >= 0 ? .green : .red)
//        Text("Open: $\(q.oPrice, specifier: "%.2f")")
//        Text("High: $\(q.hPrice, specifier: "%.2f")")
//        Text("Low: $\(q.lPrice, specifier: "%.2f")")
//        Text("Prev Close: $\(q.pClose, specifier: "%.2f")")
//    }
//}
