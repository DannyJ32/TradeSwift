//
//  ContentView.swift
//  TradeSwift
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            Tab("Home", systemImage: "house.fill") {
                HomePage()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Tab("Market", systemImage: "chart.line.uptrend.xyaxis") {
                MarketPage()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Tab("AI Insights", systemImage: "sparkles") {
                AIPage()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
