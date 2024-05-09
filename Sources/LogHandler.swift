//
//  LogHandler.swift
//
//
//  Created by Sidney Liu on 2024/5/7.
//

import Foundation

public enum LogLevel {
    case debug
    case error
    case warning
    case notice
    case info
    case critical
    case fault
}

public protocol LogHandler {
    /// Log
    func log(_ message: String, level: LogLevel, file: String, function: String, line: Int)
}
