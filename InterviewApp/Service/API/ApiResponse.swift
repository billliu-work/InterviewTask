//
//  ApiResponse.swift
//  InterviewApp
//
//  Created by Bill on 2025/5/20.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let response: T
}
