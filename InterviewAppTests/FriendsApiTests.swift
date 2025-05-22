//
//  FriendsApiTests.swift
//  InterviewAppTests
//
//  Created by Bill on 2025/5/20.
//

import Foundation
import Testing
@testable import InterviewApp

struct FriendsApiTests {
    @Test func testMock() async throws {
        try await testAll(api: FriendsMockApi())
    }

    @Test func testRemote() async throws {
        try await testAll(api: FriendsApi())
    }
}

// MARK: - Private

// Only reusing test codes due to local mock data is same as remote data
private extension FriendsApiTests {
    func testAll(api: FriendsApiProtocol) async throws {
        try await testGetUser(api: api)
        try await testGetEmptyFriendsList(api: api)
        try await testGetFriendsList1(api: api)
        try await testGetFriendsList2(api: api)
        try await testGetFriendsListWithInvites(api: api)
        try await testMergeFriends(api: api)
    }

    func testGetUser(api: FriendsApiProtocol) async throws {
        let user = try await api.getUser()
        try DataValidator.validateUser(
            user: user,
            name: "蔡國泰",
            kokoid: "Mike"
        )
    }

    func testGetEmptyFriendsList(api: FriendsApiProtocol) async throws {
        let friends = try await api.getEmptyFriendList()
        #expect(friends.isEmpty, "Friend list is not empty")
    }

    func testGetFriendsList1(api: FriendsApiProtocol) async throws {
        let friends = try await api.getFriendList1()
        #expect(friends.count == 5)
        try DataValidator.validateFriend(
            friend: friends.first,
            name: "黃靖僑",
            status: .invitationSent,
            isTop: false,
            fid: "001",
            updateDate: "2019/08/01"
        )
    }

    func testGetFriendsList2(api: FriendsApiProtocol) async throws {
        let friends = try await api.getFriendList2()
        #expect(friends.count == 3)
        try DataValidator.validateFriend(
            friend: friends.first,
            name: "黃靖僑",
            status: .invited,
            isTop: false,
            fid: "001",
            updateDate: "2019/08/02"
        )
        try DataValidator.validateFriend(
            friend: friends[1],
            name: "翁勳儀",
            status: .invited,
            isTop: true,
            fid: "002",
            updateDate: "2019/08/01"
        )
    }

    func testGetFriendsListWithInvites(api: FriendsApiProtocol) async throws {
        let friends = try await api.getFriendListWithInvite()
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

    func testMergeFriends(api: FriendsApiProtocol) async throws {
        let friendList1 = try await api.getFriendList1()
        let friendList2 = try await api.getFriendList2()

        var merged = friendList1.merge(with: friendList2)
        try checkMerged(merged)
        merged = friendList2.merge(with: friendList1)
        try checkMerged(merged)
    }

    func checkMerged(_ friends: [Friend]) throws {
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
}
