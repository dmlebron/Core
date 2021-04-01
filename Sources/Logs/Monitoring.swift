public protocol Monitoring {
    init(dsn: String, environment: Environment)

    func log(message: String, category: LogCategoryType)
}
