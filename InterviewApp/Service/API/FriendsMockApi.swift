//
//  FriendsMockApi.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

actor FriendsMockApi: FriendsApiProtocol {
    private let mockApi: MockApi

    init(delay: ContinuousClock.Instant.Duration = .milliseconds(300)) {
        mockApi = MockApi(delay: delay)
    }

    func getUser() async throws -> User {
        Logger.info("FriendsMockApi - getUser")
        return try await mockUser(
            """
            {
                "response": [
                    {
                        "name": "蔡國泰",
                        "kokoid": "Mike"
                    }
                ]
            }
            """
        )
    }

    func getEmptyFriendList() async throws -> [Friend] {
        Logger.info("FriendsMockApi - getEmptyFriendList")
        return try await mockFriends(
            """
            {
              "response": []
            }
            """
        )
    }

    func getFriendList1() async throws -> [Friend] {
        Logger.info("FriendsMockApi - getFriendList1")
        return try await mockFriends(
            """
            {
                "response": [
                    {
                        "name": "黃靖僑",
                        "status": 0,
                        "isTop": "0",
                        "fid": "001",
                        "updateDate": "20190801"
                    },
                    {
                        "name": "翁勳儀",
                        "status": 2,
                        "isTop": "1",
                        "fid": "002",
                        "updateDate": "20190802"
                    },
                    {
                        "name": "洪佳妤",
                        "status": 1,
                        "isTop": "0",
                        "fid": "003",
                        "updateDate": "20190804"
                    },
                    {
                        "name": "梁立璇",
                        "status": 1,
                        "isTop": "0",
                        "fid": "004",
                        "updateDate": "20190801"
                    },
                    {
                        "name": "梁立璇",
                        "status": 1,
                        "isTop": "0",
                        "fid": "005",
                        "updateDate": "20190804"
                    }
                ]
            }
            """
        )
    }

    func getFriendList2() async throws -> [Friend] {
        Logger.info("FriendsMockApi - getFriendList2")
        return try await mockFriends(
            """
            {
                "response": [
                    {
                        "name": "黃靖僑",
                        "status": 1,
                        "isTop": "0",
                        "fid": "001",
                        "updateDate": "2019/08/02"
                    },
                    {
                        "name": "翁勳儀",
                        "status": 1,
                        "isTop": "1",
                        "fid": "002",
                        "updateDate": "2019/08/01"
                    },
                    {
                        "name": "林宜真",
                        "status": 1,
                        "isTop": "0",
                        "fid": "012",
                        "updateDate": "2019/08/01"
                    }
                ]
            }
            """
        )
    }

    func getFriendListWithInvite() async throws -> [Friend] {
        Logger.info("FriendsMockApi - getFriendListWithInvite")
        return try await mockFriends(
            """
            {
                "response": [
                    {
                        "name": "黃靖僑",
                        "status": 0,
                        "isTop": "0",
                        "fid": "001",
                        "updateDate": "20190801"
                    },
                    {
                        "name": "翁勳儀",
                        "status": 0,
                        "isTop": "1",
                        "fid": "002",
                        "updateDate": "20190802"
                    },
                    {
                        "name": "洪佳妤",
                        "status": 1,
                        "isTop": "0",
                        "fid": "003",
                        "updateDate": "20190804"
                    },
                    {
                        "name": "彭安亭",
                        "status": 2,
                        "isTop": "0",
                        "fid": "007",
                        "updateDate": "20190802"
                    },
                    {
                        "name": "施君凌",
                        "status": 2,
                        "isTop": "0",
                        "fid": "008",
                        "updateDate": "20190803"
                    }
                ]
            }
            """
        )
    }
}

// MARK: - Private

private extension FriendsMockApi {
    func mockUser(_ jsonString: String) async throws -> User {
        try parseOneUserResponse(
            try await mockApi.mock(type: ApiResponse<[User]>.self, jsonString: jsonString)
        )
    }

    func mockFriends(_ jsonString: String) async throws -> [Friend] {
        try await mockApi.mock(type: ApiResponse<[Friend]>.self, jsonString: jsonString).response
    }
}
