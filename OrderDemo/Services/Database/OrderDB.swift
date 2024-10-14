//
//  OrderDatabase.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import Foundation
import SwiftData

final class OrderDB: SwiftDatabase {

    typealias T = Order
    
    let context: ModelContext
    
    init(modelContext: ModelContext) {
        self.context = modelContext
    }
}
