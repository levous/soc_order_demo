//
//  ContentView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import OSLog
import SwiftUI


struct OrderListView: View {
    
    private let logger: Logger = Logger.make(withType: OrderListView.self)
    let viewModel: OrderListViewModel

    var body: some View {
        
        List {
            ForEach(viewModel.orders) { order in
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
        let newOrder = Order(orderItems: [], nameOnOrder: String.randomWord().capitalized)
        Task {
            do {
                try await viewModel.save(order: newOrder)
            } catch {
                logger.error("Failed to save new order. \(error.localizedDescription)")
            }
        }
    }

    private func deleteOrders(offsets: IndexSet) {
        let ordersToDelete = offsets.map { viewModel.orders[$0] }
        Task {
            do {
                for order in ordersToDelete {
                    try await viewModel.delete(order: order)
                }
            } catch {
                logger.error("Failed to delete orders. \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    OrderListView(viewModel: OrderListViewModel())
        .modelContainer(for: OrderItem.self, inMemory: true)
}
