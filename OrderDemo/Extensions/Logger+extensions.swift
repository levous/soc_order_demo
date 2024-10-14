//
//  Logger+extensions.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import Foundation
import OSLog

extension Logger {
    /// Bundle identifier to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Default logging category.
    static let `default` = Logger(subsystem: subsystem, category: "default")
    
    /// Specialized logger for class/struct instance.
    static func make(withInstance entity: Any) -> Logger {
        Logger(subsystem: subsystem, category: String(describing: type(of: entity)))
    }
    
    /// Specialized logger for class/struct type.
    static func make<T>(withType type: T.Type) -> Logger {
        Logger(subsystem: subsystem, category: String(describing: type))
    }
    
    /// Specialized logging category.
    static func make(withCategory category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
