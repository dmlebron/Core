import Foundation

public protocol LogCategoryType {
    var rawValue: String { get }
}

public protocol Logger {
    init(bundle: Bundle?)
    
    func logError(_ message: String, category: LogCategoryType)
    func logInfo(_ message: String, category: LogCategoryType)
}
