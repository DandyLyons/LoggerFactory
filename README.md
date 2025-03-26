[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FLoggerFactory%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/DandyLyons/LoggerFactory)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FLoggerFactory%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/DandyLyons/LoggerFactory)
# LoggerFactory

A `LoggerFactory` defines all the categies within one particular subsystem and makes it easy to create consistent `Logger`s within your codebase.

## `Logger` is a much better `print()`
Most of us simply use `print()`, but there are a variety of problems with printing including: 
1. It's easy to accidentally leak private user data. 
2. `print()` gives you no context for what called `print()` or where it was called. 

To address these issues and others Apple provides the Unified Logging System which can be used through the [Logger](https://developer.apple.com/documentation/os/logger) type. 

### Advantages of Logger: 
1. separates "print" calls into subsystems
2. separates subsystems into categories
3. automatically redacts sensitive user data
### Disadvantages
1. It's just easier to `print()`... until now. 

Now it's easy to define reusable, consistent, organized `Logger`s which can be used throughout your codebase. 
## Defining a `LoggerFactory`

```swift
import Foundation
struct MyAppLogger: LoggerFactory {
    static let subsystem = Bundle.main.bundleIdentifier ?? "MyApp"
    typealias Categories = MyCategories


    enum MyCategories: String, StringRawRepresentable {
        case settings, networking, appLifeTime
    }
}
```

## Using a Logger

```swift
MyAppLogger.logger(.appLifeTime).info("App is now active.")
```

Or you can reuse loggers.

```swift
let logger = MyAppLogger.logger(.appLifeTime)
logger.info("App is now active.")
// somewhere else...
logger.info("App will soon be inactive.")
```

## Logging Errors
The library also includes convenience methods for logging Swift `Error`s. 
```swift
do {
    try throwingFunction()
} catch {
    logger.error(error)
    logger.error(error) { e in
        "throwingFunction threw Error: \(e.localizedDescription)"
    }
}
```

## License
The library is released under the MIT License. 
