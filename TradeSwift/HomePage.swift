import SwiftUI

struct HomePage: View {
    var body: some View {
        ZStack {
            Color(white: 0.15).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.GREEN_2)
                            Text("Hello, User")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Total Portfolio")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("$24,500.80")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(.GREEN_3)
                        }
                    }
                    .padding()
                    .background(Color.GREEN_1.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)

                    VStack(alignment: .leading) {
                        Text("Watchlist")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        VStack(spacing: 1) {
                            WatchlistRow(name: "AAPL", price: "$189.20", change: "+1.2%")
                            WatchlistRow(name: "TSLA", price: "$240.50", change: "-0.5%")
                            WatchlistRow(name: "NVDA", price: "$450.10", change: "+4.8%")
                        }
                    }

                    VStack(alignment: .leading) {
                        Text("Market Insights")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                InfoSquare(title: "Top Gainer", stock: "AMD", info: "+12%")
                                InfoSquare(title: "Most Active", stock: "MSFT", info: "High Vol")
                                InfoSquare(title: "Trending", stock: "BTC", info: "New Peak")
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct WatchlistRow: View {
    let name: String
    let price: String
    let change: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 60, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.GREEN_2.opacity(0.2))
                .frame(height: 30)
                .overlay(Text("Chart").font(.caption2).foregroundColor(.GREEN_2))
            
            VStack(alignment: .trailing) {
                Text(price)
                    .foregroundColor(.white)
                Text(change)
                    .font(.caption)
                    .foregroundColor(change.contains("+") ? .GREEN_3 : .red)
            }
            .frame(width: 80, alignment: .trailing)
        }
        .padding()
        .background(Color(white: 0.2))
    }
}

struct InfoSquare: View {
    let title: String
    let stock: String
    let info: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(stock)
                .font(.headline)
                .foregroundColor(.GREEN_2)
            Text(info)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 130, height: 130)
        .background(Color(white: 0.25))
        .cornerRadius(15)
    }
}

#Preview {
    HomePage()
}
