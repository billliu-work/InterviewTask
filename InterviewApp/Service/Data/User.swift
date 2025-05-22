//
//  User.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

struct User: Decodable, Hashable, Sendable {
    let name: String
    let kokoid: String?
}
