//
//  OrderEditViewModel.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import OSLog
import SwiftUI

@Observable
final class OrderEditViewModel {
    
    private let logger = Logger.make(withType: OrderEditViewModel.self)
    private let orderDataService: OrderDataService
    
    var order: Order
    
    var dateDescendingSortedOrderItems: [OrderItem] {
        order.dateDescendingSortedOrderItems
    }
    
    init(order: Order, orderDataService: OrderDataService = DataServiceFactory.shared.orderDataService()) {
        self.order = order
        self.orderDataService = orderDataService
    }
    
    func add(orderItem: OrderItem) async throws {
        withAnimation {
            orderItem.order = self.order
            order.orderItems.append(orderItem)
        }
        try await orderDataService.save(orderItem: orderItem)
    }
    
    func delete(orderItem: OrderItem) async throws {
//        withAnimation {
//            order.orderItems.removeAll { $0.persistentModelID == orderItem.persistentModelID }
//        }
        try await orderDataService.delete(orderItem: orderItem)
    }
    
    func save() async throws {
        try await orderDataService.save(order: self.order)
    }
}

