//
//  FriendsApiError.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

enum FriendsApiError: LocalizedError {
    case userNotFound
    case exceedOneUser

    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User not found"
        case .exceedOneUser:
            return "More than one user returned"
        }
    }
}
