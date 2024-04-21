import OSLog

public extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    static var subsystem = Bundle.main.bundleIdentifier ?? ""

    /// Logs the view cycles like a view that appeared.
    static let `default` = Logger(subsystem: subsystem, category: "default")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}

public func logD(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.debug("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logE(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.error("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logW(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.warning("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logN(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.notice("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logI(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.info("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logC(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.critical("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logF(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Logger.default.fault("[\(file)] \(function):\(line) \(message, privacy: .public)")
}

public func logElapsedTime<T>(_ message: String, work: () throws -> T, file: String = #fileID, function: String = #function, line: Int = #line) rethrows -> T {
    var result: T!
    let elapsedTime = try ContinuousClock().measure {
        result = try work()
    }
    logD("\(message) \(elapsedTime)", file: file, function: function, line: line)
    return result
}
