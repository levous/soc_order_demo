//
//  Order.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import Foundation
import SwiftData

@Model
final class Order {
    var createdAt: Date
    var nameOnOrder: String
    @Relationship(deleteRule: .cascade, inverse: \OrderItem.order)
    var orderItems: [OrderItem]
    
    init(orderItems: [OrderItem], nameOnOrder: String, createdAt: Date = Date()) {
        self.orderItems = orderItems
        self.nameOnOrder = nameOnOrder
        self.createdAt = createdAt
    }
}
