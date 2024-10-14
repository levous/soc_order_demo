//
//  DataServiceFactory.swift
//  OrderDemo
//
//  Created by Russell Zarse on 10/14/24.
//

import OSLog
import Foundation

/// DataService instance factory.  Provides an opportunity for dependency injection and abstraction of how data services are managed.
/// This includes mocking for tests and adding things like caching, security, etc.
class DataServiceFactory {
    
    /// Configured instances are stored and retrieved from this dictionary
    private var dataServiceInstanceCache: [String: Any] = [:]
    
    private let orderDB: any Database<Order>
    private let orderItemDB: any Database<OrderItem>

    static private var _sharedInstance: DataServiceFactory?
    
    /// Factory is a singleton configured at app launch.  This abstracts whether individual data services are shared or not and allows dependencies to be injected
    static var shared: DataServiceFactory {
        guard let instance = _sharedInstance else {
            let logger = Logger.make(withType: DataServiceFactory.self)
            logger.error("sharedInstance accessed before being configured.")
            preconditionFailure("The factory must be configured before calling sharedInstance. Do so at app or scene launch.")
        }
        return instance
    }
    
    private init(orderDB: any Database<Order>, orderItemDB: any Database<OrderItem>) {
        self.orderDB = orderDB
        self.orderItemDB = orderItemDB
    }
    
    /// Configures shared instance with provided dependencies
    static func configure(orderDB: any Database<Order>, orderItemDB: any Database<OrderItem>) {
        _sharedInstance = DataServiceFactory(orderDB: orderDB, orderItemDB: orderItemDB)
    }
    
    /// Uses cache to store and retrieve instances
    private func getCachedDataServiceInstance<T: DataService>() -> T {
        let cacheKey = String(describing: T.self)
        guard let cachedService = self.dataServiceInstanceCache[cacheKey] as? T else {
            let instance = T(orderDB: orderDB, orderItemDB: orderItemDB)
            self.dataServiceInstanceCache[cacheKey] = instance
            return instance
        }
        return cachedService
    }
    
    func orderDataService() -> OrderDataService {
        getCachedDataServiceInstance()
    }

}
