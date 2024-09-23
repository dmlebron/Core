import Logs

public final class MonitorService: Monitoring {
    private let environment: Environment
//    private let logger: Logger

    public init(dsn: String, environment: Environment) {
        self.environment = environment
//        logger = Logger(subsystem: ".com.neat-labs.\(prefix.rawValue)", category: category.rawValue)
    }
    
    public func log(message: String, category: LogCategoryType) {
    }
}
