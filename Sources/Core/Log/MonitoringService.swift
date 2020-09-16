//
//  MonitoringService.swift
//  
//
//  Created by david martinez on 9/14/20.
//

import Foundation
import Sentry

public protocol Monitoring {
    init(dsn: String, environment: Environment)
    
    func log(message: String, category: LogCategoryType)
}

public enum Environment {
    case debug
    case release(String)
    
    fileprivate var name: String {
        switch self {
        case .debug:
            return "DEBUG"
            
        case .release(let version):
            return "RELEASE - \(version)"
        }
    }
}

public final class MonitorService: Monitoring {
    private let environment: Environment
    
    public init(dsn: String, environment: Environment) {
        self.environment = environment
        
        SentrySDK.start { options in
            options.dsn = dsn
            options.debug = true
        }
    }
    
    public func log(message: String, category: LogCategoryType) {
        let event = Event(level: .error)

        event.platform = "cocoa"

        event.environment = environment.name

        event.transaction = category.rawValue

        event.message = message

        SentrySDK.capture(event: event)
    }
}
