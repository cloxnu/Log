import Foundation
import Dispatch


public class Log: LogHandler {
    
    public static let shared = Log()
    private init() {}
    private var queue = DispatchQueue(label: "nu.clox.Log")
    
    // MARK: - Handler Management
    
    private var handlers: [LogHandler] = [OSLogHandler()]
    
    public func configureHandlers(_ handlers: [LogHandler]) {
        queue.sync {
            self.handlers = handlers
        }
    }
    
    public func removeAllHandlers() {
        queue.sync {
            handlers.removeAll()
        }
    }
    
    public func appendHandler(_ handler: LogHandler) {
        queue.sync {
            handlers.append(handler)
        }
    }
    
    public func export(from fromDate: Date = Date.now.addingTimeInterval(-24 * 3600)) -> [String] {
        queue.sync {
            LogStore.export(from: fromDate)
        }
    }
    
    // MARK: - Handle
    
    public func log(
        _ message: String,
        level: LogLevel,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        queue.sync {
            for handler in handlers {
                handler.log(message, level: level, file: file, function: function, line: line)
            }
        }
    }
    
    public func logElapsedTime<T>(
        _ message: String,
        level: LogLevel,
        work: () throws -> T,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) rethrows -> T {
        var result: T!
        let elapsedTime = try ContinuousClock().measure {
            result = try work()
        }
        log("\(message) \(elapsedTime)", level: level, file: file, function: function, line: line)
        return result
    }
}

public func logD(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .debug, file: file, function: function, line: line)
}

public func logE(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .error, file: file, function: function, line: line)
}

public func logW(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .warning, file: file, function: function, line: line)
}

public func logN(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .notice, file: file, function: function, line: line)
}

public func logI(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .info, file: file, function: function, line: line)
}

public func logC(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .critical, file: file, function: function, line: line)
}

public func logF(_ message: String, file: String = #fileID, function: String = #function, line: Int = #line) {
    Log.shared.log(message, level: .fault, file: file, function: function, line: line)
}

public func logElapsedTime<T>(_ message: String, work: () throws -> T, file: String = #fileID, function: String = #function, line: Int = #line) rethrows -> T {
    return try Log.shared.logElapsedTime(message, level: .debug, work: work, file: file, function: function, line: line)
}
