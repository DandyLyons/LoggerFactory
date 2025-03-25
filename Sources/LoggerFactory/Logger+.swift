//
//  File.swift
//  LoggerFactory
//
//  Created by Daniel Lyons on 2025-03-24.
//

import Foundation
import OSLog

extension Logger {
    /// Logs a Swift `Error`, with an optional label and message.
    public func error(
        _ error: any Error,
        errorLabel: String? = nil,
        message: String? = nil
    ) {
        self.error("\(message ?? "") \(errorLabel ?? "Error"): \(error.localizedDescription)")
    }
    
    /// Logs a Swift `Error`, according to the given format. 
    public func error<E: Error>(
        _ error: E,
        format: @Sendable @escaping (E) -> String
    ) {
        self.error("\(format(error))")
    }
}
