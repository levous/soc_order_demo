//
//  ContentView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import SwiftUI
import SwiftData

struct OrderListView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var orders: [Order]

    var body: some View {
        
        List {
            ForEach(orders) { order in
                NavigationLink {
                    OrderEditView(order: order)
                } label: {
                    Text("\(order.nameOnOrder) at ") +
                    Text(order.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteOrders)
        }
        .toolbar {
            ToolbarItem {
                Button(action: addOrder) {
                    Label("Add Order", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Orders")
       
    }

    private func addOrder() {
        withAnimation {
            let newOrder = Order(orderItems: [], nameOnOrder: String.randomWord().capitalized)
            modelContext.insert(newOrder)
        }
    }

    private func deleteOrders(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(orders[index])
            }
        }
    }
}

#Preview {
    OrderListView()
        .modelContainer(for: OrderItem.self, inMemory: true)
}
