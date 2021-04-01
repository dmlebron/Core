import Foundation
import os

public struct Log {
    private let bundleIdentifier: String?
    private let environment: Environment
    private let monitoring: Monitoring?
    
    public init(urlString: String?, environment: Environment, bundle: Bundle?, monitoring: Monitoring?) {
        self.environment = environment
        self.bundleIdentifier = bundle?.bundleIdentifier
        self.monitoring = monitoring
    }
}

// MARK: - Logger

extension Log: Logger {
    public func logError(_ message: String, category: LogCategoryType) {
        log(type: .error, message: message, category: category)
        
        monitoring?.log(message: message, category: category)
    }
    
    public func logInfo(_ message: String, category: LogCategoryType) {
        log(type: .info, message: message, category: category)
    }
}

// MARK: - Private

private extension Log {
    func systemLog(category: LogCategoryType) -> OSLog {
        if let bundleIdentifier = bundleIdentifier {
            return OSLog(subsystem: bundleIdentifier, category: category.rawValue)
        }
        
        return .default
    }
    
    func log(type: OSLogType, message: String, category: LogCategoryType) {
        os_log(type, log: systemLog(category: category), "%@", message as CVarArg)
    }
}
