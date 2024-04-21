//
//  LogStore.swift
//  
//
//  Created by Sidney Liu on 2023/11/29.
//

import OSLog
import Foundation

public class LogStore {
    
    public static func export(
        fromLastestBoot: TimeInterval,
        subsystem: String = Logger.subsystem
    ) -> [String] {
        export(position: { $0.position(timeIntervalSinceLatestBoot: fromLastestBoot) }, subsystem: subsystem)
    }
    
    public static func export(
        from fromDate: Date = Date.now.addingTimeInterval(-24 * 3600),
        subsystem: String = Logger.subsystem
    ) -> [String] {
        export(position: { $0.position(date: fromDate) }, subsystem: subsystem)
    }
    
    public static func export(
        position: ((OSLogStore) -> OSLogPosition?)?,
        subsystem: String = Logger.subsystem
    ) -> [String] {
        do {
            let store = try OSLogStore(scope: .currentProcessIdentifier)
            let position = position?(store)
            
            return try store
                .getEntries(at: position)
                .compactMap { $0 as? OSLogEntryLog }
                .filter { $0.subsystem == subsystem }
                .map { "[\($0.date.formatted())] [\($0.category)] \($0.composedMessage)" }
        } catch {
            logE("Export Failed: \(error)")
        }
        return []
    }
}
