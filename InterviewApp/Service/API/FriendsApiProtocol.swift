//
//  FriendsApiProtocol.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

protocol FriendsApiProtocol {
    func getUser() async throws -> User
    func getEmptyFriendList() async throws -> [Friend]
    func getFriendList1() async throws -> [Friend]
    func getFriendList2() async throws -> [Friend]
    func getFriendListWithInvite() async throws -> [Friend]
}

// MARK: - Common

extension FriendsApiProtocol {
    func parseOneUserResponse(_ apiResponse: ApiResponse<[User]>) throws -> User {
        let response = apiResponse.response
        guard response.count <= 1 else { throw FriendsApiError.exceedOneUser }
        guard let user = response.first else { throw FriendsApiError.userNotFound }
        return user
    }
}
