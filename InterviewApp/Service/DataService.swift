//
//  DataService.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

actor DataService {
    private let api: FriendsApiProtocol

    init(api: FriendsApiProtocol) {
        self.api = api
    }

    func loadUser() async throws -> User {
        try await api.getUser()
    }

    func loadFriends(_ scenario: Scenario) async throws -> [Friend] {
        switch scenario {
        case .scenario1:
            return try await api.getEmptyFriendList()
        case .scenario2:
            async let asyncList1 = api.getFriendList1()
            async let asyncList2 = api.getFriendList2()
            let (list1, list2) = (try await asyncList1, try await asyncList2)
            return list1.merge(with: list2)
        case .scenario3:
            return try await api.getFriendListWithInvite()
        }
    }
}

// MARK: - Scenario

extension DataService {
    enum Scenario: Int {
        case scenario1 = 1
        case scenario2 = 2
        case scenario3 = 3
    }
}


