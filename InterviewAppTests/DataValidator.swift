//
//  DataValidator.swift
//  InterviewAppTests
//
//  Created by Bill on 2025/5/20.
//

import Foundation
import Testing
@testable import InterviewApp

enum DataValidator {
    private static let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    static func validateUser(
        user: User?,
        name: String? = nil,
        kokoid: String? = nil
    ) throws {
        let user = try #require(user, "User cannot be nil")
        if let name {
            #expect(user.name == name, "Expected name [\(name)], got [\(user.name)]")
        }
        if let kokoid {
            #expect(user.kokoid == kokoid, "Expected kokoid [\(kokoid)], got [\(String(describing: user.kokoid))]")
        }
    }

    static func validateFriend(
        friend: Friend?,
        name: String? = nil,
        status: Friend.Status? = nil,
        isTop: Bool? = nil,
        fid: String? = nil,
        updateDate: String? = nil
    ) throws {
        let friend = try #require(friend, "Friend cannot be nil")
        if let name {
            #expect(friend.name == name, "Expected name [\(name)], got [\(friend.name)]")
        }
        if let status {
            #expect(friend.status == status, "Unexpected status [\(status)], got [\(friend.status)]")
        }
        if let isTop {
            #expect(friend.isTop == isTop, "Unexpected friend isTop value [\(isTop)], got [\(friend.isTop)]")
        }
        if let fid {
            #expect(friend.fid == fid, "Unexpected friend fid [\(fid)], got [\(friend.fid)]")
        }
        if let updateDate {
            #expect(friend.updateDate == getDate(updateDate), "Unexpected friend updateDate [\(dateFormatter.string(from: friend.updateDate))], got [\(updateDate)]")
        }
    }

    private static func getDate(_ string: String) -> Date? {
        dateFormatter.date(from: string).flatMap { Calendar.current.startOfDay(for: $0) }
    }
}
