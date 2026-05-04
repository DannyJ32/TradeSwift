//
//  HomePage.swift
//  TradeSwift
//
//  Created by Student on 4/29/26.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        VStack {
            HStack {
                Text("Hello")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.GREEN_1)
            HStack {
                Text("Test")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.GREEN_2)
            HStack {
                Text("Last")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.GREEN_3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomePage()
}
