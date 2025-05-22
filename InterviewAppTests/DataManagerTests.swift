//
//  DataServiceTests.swift
//  InterviewAppTests
//
//  Created by Bill on 2025/5/20.
//

import Testing
@testable import InterviewApp

struct DataServiceTests {
    private let dataManager = DataService(api: FriendsMockApi())

    @Test func testAll() async throws {
        try await testUser()
        try await testFriendListScenario1()
        try await testFriendListScenario2()
        try await testFriendListScenario3()
    }

    @Test func testUser() async throws {
        let user = try await dataManager.loadUser()
        try DataValidator.validateUser(
            user: user,
            name: "蔡國泰",
            kokoid: "Mike"
        )
    }

    @Test func testFriendListScenario1() async throws {
        let friends = try await dataManager.loadFriends(.scenario1)
        #expect(friends.isEmpty, "Friend list is not empty")
    }

    @Test func testFriendListScenario2() async throws {
        let friends = try await dataManager.loadFriends(.scenario2)
        #expect(friends.count == 6)
        try DataValidator.validateFriend(
            friend: friends.first { $0.fid == "001" },
            status: .invited,
            updateDate: "2019/08/02"
        )
        try DataValidator.validateFriend(
            friend: friends.first { $0.fid == "002" },
            status: .inviting,
            updateDate: "2019/08/02"
        )
    }

    @Test func testFriendListScenario3() async throws {
        let friends = try await dataManager.loadFriends(.scenario3)
        #expect(friends.count == 5)
        try DataValidator.validateFriend(
            friend: friends.last,
            name: "施君凌",
            status: .inviting,
            isTop: false,
            fid: "008",
            updateDate: "2019/08/03"
        )
    }
}
