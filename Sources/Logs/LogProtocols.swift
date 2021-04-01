import Foundation

public protocol LogCategoryType {
    var rawValue: String { get }
}

public protocol Logger {
    
    /// Initilizer
    /// - Parameter urlString: optional url string. This url is where the logs should be sent.
    /// - Parameter environment: current environment (debug/release)
    /// - Parameter bundle: main application bundle
    init(urlString: String?, environment: Environment, bundle: Bundle?, monitoring: Monitoring?)
    
    func logError(_ message: String, category: LogCategoryType)
    func logInfo(_ message: String, category: LogCategoryType)
}
