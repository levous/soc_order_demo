//
//  OrderEditView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import OSLog
import SwiftUI
import SwiftData

struct OrderEditView: View {
    
    private let logger = Logger.make(withType: OrderEditView.self)
    let viewModel: OrderEditViewModel
    
    init(order: Order) {
        self.init(viewModel: OrderEditViewModel(order: order))
    }
    
    init(viewModel: OrderEditViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            if viewModel.order.orderItems.isEmpty {
                Button("Add an Order Item") {
                    addItem()
                }
            }
            
            ForEach(viewModel.dateDescendingSortedOrderItems) { item in
                NavigationLink {
                    OrderItemDetailView(orderItem: item)
                } label: {
                    Text("Item \(item.itemTitle) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }

            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .navigationTitle("\(viewModel.order.nameOnOrder) Order Items")
    }

    private func addItem() {
        let newItem = OrderItem(itemTitle: String.randomWord().capitalized)
        Task {
            do {
                try await viewModel.add(orderItem: newItem)
            } catch {
                logger.error("Failed to add new order item. \(error.localizedDescription)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        
        let orderItems = offsets.map { viewModel.dateDescendingSortedOrderItems[$0] }
        Task {
            do {
                for orderItem in orderItems {
                    try await viewModel.delete(orderItem: orderItem)
                }
            } catch {
                logger.error("Failed to delete order item. \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    OrderEditView(order: PreviewData.orders[0])
}
