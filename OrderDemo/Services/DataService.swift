//
//  DataService.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import Foundation
import SwiftData

enum DataServiceError: Error {
    case notFound
}

protocol DataService {
    init(orderDB: any Database<Order>, orderItemDB: any Database<OrderItem>)
}

class OrderDataService: DataService {
    
    private let orderDB: any Database<Order>
    private let orderItemDB: any Database<OrderItem>
    
    required init(orderDB: any Database<Order>, orderItemDB: any Database<OrderItem>) {
        self.orderDB = orderDB
        self.orderItemDB = orderItemDB
    }
    
    func fetchOrders() async throws -> [Order] {
        try await orderDB.read(sortBy:
                SortDescriptor<Order>(\.createdAt),
                SortDescriptor<Order>(\.nameOnOrder)
        )
    }
    
    func fetchOrder(byPersistentID persistentModelID: PersistentIdentifier) async throws -> Order {
        let orders = try await fetchOrders()
        guard let order = orders.first(where: { candidateOrder in
            candidateOrder.persistentModelID == persistentModelID
        }) else {
            throw DataServiceError.notFound
        }
        return order
    }
    
    func save(order: Order) async throws {
        try orderDB.update(order)
    }
    
    func save(orderItem: OrderItem) async throws {
        try orderItemDB.update(orderItem)
    }
    
    func delete(order: Order) async throws {
        try orderDB.delete(order)
    }
    
    func delete(orderItem: OrderItem) async throws {
        if let order = orderItem.order,
           !order.orderItems.isEmpty {
            order.orderItems.removeAll { orderItem.persistentModelID == $0.persistentModelID }
            try orderDB.update(order)
        }
        try orderItemDB.delete(orderItem)
    }
}
