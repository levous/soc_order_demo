//
//  OrderItemDB.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import Foundation
import SwiftData

final class OrderItemDB: SwiftDatabase {
    
    typealias T = OrderItem
    
    let context: ModelContext
    
    init(modelContext: ModelContext) {
        self.context = modelContext
    }
}
