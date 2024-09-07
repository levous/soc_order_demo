//
//  Item.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import Foundation
import SwiftData

@Model
final class OrderItem {
    var createdAt: Date
    var itemTitle: String
    var order: Order?
    
    init(itemTitle: String, createdAt: Date = Date()) {
        self.itemTitle = itemTitle
        self.createdAt = createdAt
    }
}
