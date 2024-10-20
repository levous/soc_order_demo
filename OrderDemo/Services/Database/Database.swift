//
//  Database.swift
//  OrderDemo
//
//  from: https://github.com/jacobsapps/NoSwiftDataNoUI/blob/main/NoSwiftDataNoUI/DB/Database.swift

import Foundation

protocol Database<T> {
    associatedtype T
    func create(_ item: T) throws
    func create(_ items: [T]) throws
    func read(sortBy sortDescriptors: SortDescriptor<T>...) async throws -> [T]
    func update(_ item: T) throws
    func delete(_ item: T) throws
}


