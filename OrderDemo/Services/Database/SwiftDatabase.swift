//
//  SwiftDatabase.swift
//  OrderDemo
//
//  from: https://github.com/jacobsapps/NoSwiftDataNoUI/blob/main/NoSwiftDataNoUI/DB/SwiftDatabase.swift
//

import Foundation
import SwiftData

enum SwiftDatabaseError: Error {
    case modelNotFound
}

protocol SwiftDatabase<T>: Database {
    associatedtype T = PersistentModel
    var context: ModelContext{ get }
    init(modelContext: ModelContext)
}

extension SwiftDatabase {
    
    func create<T: PersistentModel>(_ items: [T]) throws {
        for item in items {
            context.insert(item)
        }
        try context.save()
    }
    
    func create<T: PersistentModel>(_ item: T) throws {
        context.insert(item)
        try context.save()
    }
    
    func read<T: PersistentModel>(sortBy sortDescriptors: SortDescriptor<T>...) throws -> [T] {
        let fetchDescriptor = FetchDescriptor<T>(
            sortBy: sortDescriptors
        )
        return try context.fetch(fetchDescriptor)
    }
    
    func update<T: PersistentModel>(_ item: T) throws {
        context.insert(item)
        try context.save()
    }
    
    func delete<T: PersistentModel>(_ item: T) throws {
        let idToDelete = item.persistentModelID
        guard let model = context.model(for: idToDelete) as? T else {
            throw SwiftDatabaseError.modelNotFound
        }
        context.delete(model)
        try context.save()
    }
}
