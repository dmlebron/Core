import Foundation
import os

public struct Log {
    private let bundleIdentifier: String?
    private let environment: Environment
    private let monitoringService: Monitoring?
    
    public init(urlString: String?, environment: Environment, bundle: Bundle?) {
        self.environment = environment
        self.bundleIdentifier = bundle?.bundleIdentifier
        
        if let urlString = urlString {
            self.monitoringService = MonitorService(dsn: urlString, environment: environment)
        } else {
            self.monitoringService = nil
        }
    }
}

// MARK: - Logger

extension Log: Logger {
    public func logError(_ message: String, category: LogCategoryType) {
        log(type: .error, message: message, category: category)
        
        monitoringService?.log(message: message, category: category)
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
