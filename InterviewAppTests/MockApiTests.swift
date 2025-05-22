//
//  MockApiTests.swift
//  InterviewAppTests
//
//  Created by Bill on 2025/5/20.
//

import Testing
@testable import InterviewApp

struct MockApiTests {
    private let mockApi = MockApi()

    @Test func testAll() async throws {
        try await testValidJson()
        try await testInvalidJson()
    }

    @Test func testValidJson() async throws {
        let jsonString = """
            {
                "text": "Hello world",
                "value": 123
            }
            """
        let object = try await mockApi.mock(type: TestObject.self, jsonString: jsonString)
        #expect(object.text == "Hello world")
        #expect(object.value == 123)
    }

    @Test func testInvalidJson() async throws {
        let mockApi = MockApi()
        let jsonString = "foo, bar"
        let object = try? await mockApi.mock(type: TestObject.self, jsonString: jsonString)
        #expect(object == nil)
    }
}

private struct TestObject: Decodable {
    let text: String
    let value: Int
}
