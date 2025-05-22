//
//  MockApi.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

public enum MockApiError: Error {
    case invalidInput
}

public actor MockApi {
    private let decoder: JSONDecoder
    private let delay: ContinuousClock.Instant.Duration

    public init(
        decoder: JSONDecoder? = nil,
        delay: ContinuousClock.Instant.Duration = .milliseconds(300)
    ) {
        self.decoder = decoder ?? JSONDecoder()
        self.delay = delay
    }

    public func mock<T: Decodable>(type: T.Type, jsonString: String) async throws -> T {
        try await Task.sleep(for: delay)
        try Task.checkCancellation()
        guard let data = jsonString.data(using: .utf8) else {
            throw MockApiError.invalidInput
        }
        return try decoder.decode(type, from: data)
    }
}
