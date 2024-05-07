//
//  OSLogHandler.swift
//
//
//  Created by Sidney Liu on 2024/5/7.
//

import Foundation
import OSLog

public extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    static var subsystem = Bundle.main.bundleIdentifier ?? ""

    /// Logs the view cycles like a view that appeared.
    static let `default` = Logger(subsystem: subsystem, category: "default")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}

public class OSLogHandler: LogHandler {
    
    public func log(_ message: String, level: LogLevel, file: String, function: String, line: Int) {
        switch level {
        case .debug:
            Logger.default.debug("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .error:
            Logger.default.error("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .warning:
            Logger.default.warning("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .notice:
            Logger.default.notice("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .info:
            Logger.default.info("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .critical:
            Logger.default.critical("[\(file)] \(function):\(line) \(message, privacy: .public)")
        case .fault:
            Logger.default.fault("[\(file)] \(function):\(line) \(message, privacy: .public)")
        }
    }
}
