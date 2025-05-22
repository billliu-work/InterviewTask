//
//  Friend.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

struct Friend: Hashable, Sendable {
    let name: String
    let status: Friend.Status
    let isTop: Bool
    let fid: String
    let updateDate: Date

    // Internal status
    let declined: Bool
}

extension Friend {
    enum Status: Int, Hashable, Decodable {
        case invitationSent = 0
        case invited = 1
        case inviting = 2
    }
}

// MARK: - Decodable

extension Friend: Decodable {
    private enum CodingKeys : String, CodingKey {
        case name
        case status
        case isTop
        case fid
        case updateDate
    }

    private static let dateFormatter1 = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    private static let dateFormatter2 = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(Friend.Status.self, forKey: .status)
        // Making assumption only "1" means isTop is true
        isTop = (try container.decode(String.self, forKey: .isTop)) == "1"
        fid = try container.decode(String.self, forKey: .fid)

        // It seems there are two different possible format for updateDate, so instead of using
        // formatted dateDecodingStrategy in JSONDecoder, will manually try different date formatter
        let dateString = try container.decode(String.self, forKey: .updateDate)
        if let date = Friend.dateFormatter1.date(from: dateString) ?? Friend.dateFormatter2.date(from: dateString) {
            // Since updateDate only contains date and not time, force time to start of day
            updateDate = Calendar.current.startOfDay(for: date)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.updateDate,
                in: container,
                debugDescription: "Invalid updateDate"
            )
        }

        declined = false
    }
}

// MARK: - Extension

extension Friend {
    func copyWithNewStatus(_ newStatus: Friend.Status) -> Friend {
        .init(
            name: name,
            status: newStatus,
            isTop: isTop,
            fid: fid,
            updateDate: Date(),
            declined: false
        )
    }

    func copyAsDeclined() -> Friend {
        .init(
            name: name,
            status: status,
            isTop: isTop,
            fid: fid,
            updateDate: Date(),
            declined: true
        )
    }
}

extension [Friend] {
    func merge(with other: [Friend]) -> [Friend] {
        var array = self
        var indexMap = [String: Int]()
        for i in 0..<array.count {
            indexMap[array[i].fid] = i
        }
        other.forEach { friend in
            if let index = indexMap[friend.fid] {
                if friend.updateDate > array[index].updateDate {
                    array[index] = friend
                }
            } else {
                array.append(friend)
            }
        }
        return array
    }
}
