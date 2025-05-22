//
//  InterviewAppTests.swift
//  InterviewAppTests
//
//  Created by Bill on 2025/5/19.
//

import Testing
@testable import InterviewApp

struct InterviewAppTests {
    @Test func test() async throws {
        let mockApiTests = MockApiTests()
        try await mockApiTests.testAll()

        let friendsApiTests = FriendsApiTests()
        try await friendsApiTests.testMock()
//        try await friendsApiTests.testRemote()

        let dataManagerTests = DataServiceTests()
        try await dataManagerTests.testAll()
    }
}
