import Foundation
import os

public struct Log {
    private let bundleIdentifier: String?
    
    public init(bundle: Bundle?) {
        self.bundleIdentifier = bundle?.bundleIdentifier
    }
}

// MARK: - Logger

extension Log: Logger {
    public func logError(_ message: String, category: LogCategoryType) {
        os_log(.error, log: systemLog(category: category), "%@", message as CVarArg)
    }
    
    public func logInfo(_ message: String, category: LogCategoryType) {
        os_log(.info, log: systemLog(category: category), "%@", message as CVarArg)
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
}
