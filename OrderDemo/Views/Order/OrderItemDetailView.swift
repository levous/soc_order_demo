//
//  OrderItemDetailView.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import SwiftUI

struct OrderItemDetailView: View {
    
    let orderItem: OrderItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("name on order").captionText()
                Text(orderItem.order?.nameOnOrder ?? "Order is nil").font(.title2)
            }
            
            Divider()
            
            Grid {
                GridRow {
                    Text("title").captionText()
                        .gridColumnAlignment(.trailing)
                    Text(orderItem.itemTitle)
                        .gridColumnAlignment(.leading)
                }
                GridRow {
                    Text("created at").captionText()
                    Text(
                        orderItem.createdAt,
                        format: Date.FormatStyle(date: .numeric, time: .standard)
                    )
                }
            }
            
        }.navigationTitle("Order Item Detail")
    }
}

#Preview {
    OrderItemDetailView(orderItem: PreviewData.orders[0].orderItems[0])
}
