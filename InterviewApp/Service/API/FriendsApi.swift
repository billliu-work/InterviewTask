//
//  FriendsApi.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

actor FriendsApi: FriendsApiProtocol {
    private let session: URLSession = URLSession.shared
    private let decoder = JSONDecoder()

    init() {}

    func getUser() async throws -> User {
        Logger.info("FriendsApi - getUser")
        let response = try await download("https://dimanyen.github.io/man.json", type: ApiResponse<[User]>.self)
        return try parseOneUserResponse(response)
    }

    func getEmptyFriendList() async throws -> [Friend] {
        Logger.info("FriendsApi - getEmptyFriendList")
        return try await downloadFriendList("https://dimanyen.github.io/friend4.json")
    }

    func getFriendList1() async throws -> [Friend] {
        Logger.info("FriendsApi - getFriendList1")
        return try await downloadFriendList("https://dimanyen.github.io/friend1.json")
    }

    func getFriendList2() async throws -> [Friend] {
        Logger.info("FriendsApi - getFriendList2")
        return try await downloadFriendList("https://dimanyen.github.io/friend2.json")
    }

    func getFriendListWithInvite() async throws -> [Friend] {
        Logger.info("FriendsApi - getFriendListWithInvite")
        return try await downloadFriendList("https://dimanyen.github.io/friend3.json")
    }

    private func downloadFriendList(_ urlString: String) async throws -> [Friend] {
        try await download(urlString, type: ApiResponse<[Friend]>.self).response
    }

    private func download<T: Decodable>(_ urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        Logger.debug("FriendsApi - downloading file from [\(urlString)]")
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(type, from: data)
    }
}
