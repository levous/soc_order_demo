//
//  OrderDemoApp.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import OSLog
import SwiftUI
import SwiftData

@main
struct OrderDemoApp: App {
    
    private let logger = Logger.make(withType: OrderDemoApp.self)
    
    init() {
        
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: Order.self, OrderItem.self, configurations: configuration)
            let modelContext = ModelContext(container)
            DataServiceFactory.configure(
                orderDB: OrderDB(modelContext: modelContext),
                orderItemDB: OrderItemDB(modelContext: modelContext)
            )
        } catch {
            logger.error("Failed to configure DataServiceFactory. \(error.localizedDescription)")
        }
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
