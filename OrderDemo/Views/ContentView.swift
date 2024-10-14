//
//  ContentView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            OrderListView(viewModel: OrderListViewModel())
        }
    }
}

#Preview {
    ContentView()
}
