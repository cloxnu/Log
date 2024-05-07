//
//  LogExporter.swift
//  
//
//  Created by Sidney Liu on 2024/5/7.
//

import OSLog
import Foundation
import CoreTransferable

public class LogExporter: Transferable {
    
    public init() {}
    
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .text) { logExporter in
            let logString = LogStore.export().joined(separator: "\n")
            return logString.data(using: .utf8) ?? Data()
        }
    }
}
