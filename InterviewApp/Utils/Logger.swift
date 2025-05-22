//
//  Logger.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

public final class Logger {
    public static let shared = Logger()

    private let queue = DispatchQueue(label: "com.interviewapp.logger")

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter
    }()

    private var level: Logger.Level = .info

    private init() {}

    public func setLevel(_ level: Logger.Level) {
        queue.async {
            self.level = level
        }
    }

    public func info(_ message: String) {
        log(level: .info, message: message)
    }

    public func debug(_ message: String) {
        log(level: .debug, message: message)
    }

    public func warning(_ message: String) {
        log(level: .warning, message: message)
    }

    public func error(_ message: String) {
        log(level: .error, message: message)
    }

    private func log(level: Logger.Level, message: String) {
        queue.async {
            guard level.rawValue <= self.level.rawValue else { return }
            print("[\(self.dateFormatter.string(from: Date()))][\(level.displayText)] \(message)")
        }
    }
}

// MARK: - Level

public extension Logger {
    enum Level: Int {
        case none
        case error
        case warning
        case debug
        case info
    }
}

private extension Logger.Level {
    var displayText: String {
        switch self {
        case .none:
            return "NONE"
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }
}

// MARK: - Convenience

public extension Logger {
    static func info(_ message: String) {
        shared.info(message)
    }

    static func debug(_ message: String) {
        shared.debug(message)
    }

    static func warning(_ message: String) {
        shared.warning(message)
    }

    static func error(_ message: String) {
        shared.error(message)
    }
}
