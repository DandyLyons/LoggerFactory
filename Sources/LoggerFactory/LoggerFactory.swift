//
//  LoggerFactory.swift
//  LoggerFactory
//
//  Created by Daniel Lyons on 2025-03-24.
//

import Foundation
@_exported import OSLog

/// A unified interface for defining `Logger`s within your code.
///
/// A LoggerFactory defines all the categies within one particular subsystem and makes it easy to create consistent `Logger`s within your codebase.
///
/// ## Defining a `LoggerFactory`
/// ```swift
/// import Foundation
/// struct MyAppLogger: LoggerFactory {
///     static let subsystem = Bundle.main.bundleIdentifier ?? "MyApp"
///     typealias Categories = MyCategories
///
///     enum MyCategories: String, StringRawRepresentable {
///         case settings, networking, appLifeTime
///     }
/// }
/// ```
///
/// ## Using a Logger
/// ```swift
///MyAppLogger.logger(.appLifeTime).info("App is now active.")
/// ```
/// Or you can reuse loggers.
/// ```swift
/// let logger = MyAppLogger.logger(.appLifeTime)
/// logger.info("App is now active.")
/// // somewhere else...
/// logger.info("App will soon be inactive.")
/// ```
public protocol LoggerFactory {
    /// The string that identifies the subsystem that emits signposts. Typically, you use the same value as your app’s bundle ID. For more information, see CFBundleIdentifier.
    static var subsystem: String { get }
    
    /// The possible categories within your subsystem.
    ///
    /// See [Apple documentation](https://developer.apple.com/documentation/os/logger/init(subsystem:category:)).
    associatedtype Categories: StringRawRepresentable
    
    static func logger(_ category: Categories) -> Logger 
}

extension LoggerFactory {
    public static func logger(_ category: Categories) -> Logger {
        Logger(subsystem: Self.subsystem, category: category.rawValue)
    }
}

public protocol StringRawRepresentable: RawRepresentable where RawValue == String {}
