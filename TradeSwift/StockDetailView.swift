import SwiftUI

struct StockDetailView: View {
    let symbol: String
    let name: String
    let quote: StockQuote?

    @State private var vm = StockDetailViewModel()

    var body: some View {
        ZStack {
            Color(white: 0.15).ignoresSafeArea()

            if let q = vm.quote {
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 10) {
                            Text("$\(String(format: "%.2f", q.current))")
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                                .foregroundColor(.white)

                            HStack(spacing: 10) {
                                if q.change >= 0 {
                                    Text("+\(String(format: "%.2f", q.change))$")
                                } else {
                                    Text("\(String(format: "%.2f", q.change))$")
                                }
                                
                                Divider()
                                
                                if q.percentChange >= 0 {
                                    Text("+\(String(format: "%.2f", q.percentChange))%")
                                } else {
                                    Text("\(String(format: "%.2f", q.percentChange))%")
                                }
                            }
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(q.percentChange >= 0 ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                            .foregroundColor(q.percentChange >= 0 ? .green : .red)
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.GREEN_1.opacity(0.3))
                        .cornerRadius(20)
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("TODAY'S STATS")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                                StatCard(label: "Open", value: "$\(String(format: "%.2f", q.oPrice))")
                                StatCard(label: "Prev Close", value: "$\(String(format: "%.2f", q.pClose))")
                                StatCard(label: "High", value: "$\(String(format: "%.2f", q.hPrice))")
                                StatCard(label: "Low", value: "$\(String(format: "%.2f", q.lPrice))")
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            } else {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Loading \(symbol)...")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(symbol)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.load(symbol: symbol, preloaded: quote)
        }
    }
}

struct StatCard: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(white: 0.22))
        .cornerRadius(14)
    }
}

#Preview {
    NavigationStack {
        StockDetailView(
            symbol: "AAPL",
            name: "Apple Inc.",
            quote: StockQuote(
                current: 185.92,
                change: 1.25,
                percentChange: 0.68,
                hPrice: 186.40,
                lPrice: 184.20,
                oPrice: 183.50,
                pClose: 184.67,
                t: 1.023
            )
        )
    }
}
