//
//  OrderListViewModel.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import OSLog
import SwiftUI

@Observable
final class OrderListViewModel {
    
    private let logger = Logger.make(withType: OrderListViewModel.self)
    private let orderDataService: OrderDataService
    
    var orders: [Order]
    
    init(orderDataService: OrderDataService = DataServiceFactory.shared.orderDataService()) {
        self.orders = []
        self.orderDataService = orderDataService
        
        Task {
            do {
                try await fetchOrders()
            } catch {
                logger.error("Failed to fetch orders \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchOrders() async throws {
        let fetchedOrders = try await self.orderDataService.fetchOrders()
        withAnimation {
            self.orders = fetchedOrders
        }
    }
    
    func save(order: Order) async throws {
        try await orderDataService.save(order: order)
        try await self.fetchOrders()
    }
    
    func delete(order: Order) async throws {
        try await orderDataService.delete(order: order)
        try await self.fetchOrders()
    }
}
