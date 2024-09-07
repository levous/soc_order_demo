//
//  OrderEditView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//


import SwiftUI
import SwiftData

struct OrderEditView: View {
    @Environment(\.modelContext) private var modelContext
    
    let order: Order

    var body: some View {
        List {
            if order.orderItems.isEmpty {
                Button("Add an Order Item") {
                    addItem()
                }
            }
            
            ForEach(order.orderItems) { item in
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
        .navigationTitle("\(order.nameOnOrder) Order Items")
    }

    private func addItem() {
        withAnimation {
            let newItem = OrderItem(itemTitle: String.randomWord().capitalized)
            newItem.order = order
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(order.orderItems[index])
            }
        }
    }
}

#Preview {
    OrderEditView(order: PreviewData.orders[0])
        .modelContainer(for: OrderItem.self, inMemory: true)
}
