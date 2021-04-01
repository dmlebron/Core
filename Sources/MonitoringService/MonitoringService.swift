import Sentry
import Logs

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
