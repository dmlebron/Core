//
//  MonitoringService.swift
//  
//
//  Created by david martinez on 9/14/20.
//

import Foundation
import Sentry

public protocol Monitoring {
    init(dsn: String, isDebug: Bool, environment: Environment)
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

public final class MonitorService {
    private let environment: Environment
    private let log: Logger
    
    public init(dsn: String, isDebug: Bool, environment: Environment, bundle: Bundle?) {
        self.environment = environment
        
        self.log = Log(bundle: bundle)
        
        SentrySDK.start { options in
            options.dsn = dsn
            options.debug = isDebug as NSNumber
        }
    }
    
    public func log() {
        let event = Event()
        
        let event = Event(level: .error)
        
        event.platform = "cocoa"
        
        event.environment = environment.name
        
//        event.transaction = category.rawValue
        
//        event.message = detailedMessage
        
        SentrySDK.capture(event: event)
    }
}
