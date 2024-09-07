//
//  PreviewData.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import SwiftData
import SwiftUI


@MainActor
class PreviewDataController {
    
    static let modelContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let schema = Schema([Order.self])
            let container = try ModelContainer(for: schema, configurations: [config])
            return container
        }
        catch {
            print("Failed to create preview ModelContainer")
            // This is not expected to correct the problem
            return try! ModelContainer(for: Order.self)
        }
        
    }()
}

@MainActor
struct PreviewData {
    
    static let modelContainer = PreviewDataController.modelContainer
    
    static let orders = {
        let modelContainer = PreviewData.modelContainer
        let orders = [
            Order(
                orderItems: [
                    OrderItem(itemTitle: "Blonde Wig"),
                    OrderItem(itemTitle: "Fake Nose"),
                    OrderItem(itemTitle: "Costume Glasses")
                ],
                nameOnOrder: "Fred Flinstone"
            ),
            Order(
                orderItems: [
                    OrderItem(itemTitle: "Sun Umbrella")
                ],
                nameOnOrder: "Barney Rubble"
            ),
            Order(
                orderItems: [
                    OrderItem(itemTitle: "Borla Exhaust Kit"),
                    OrderItem(itemTitle: "Carbon Fiber Sideview Mirrors")
                ],
                nameOnOrder: "Betty Rubble"
            )
        ]
        
        orders.forEach { order in
            modelContainer.mainContext.insert(order)
        }
        
        
        return orders
    }()

}




