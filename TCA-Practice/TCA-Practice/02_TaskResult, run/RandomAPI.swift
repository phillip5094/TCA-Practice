//
//  RandomAPI.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/13
//

import Foundation

enum RandomAPIError: Error {
    case unknown
}

extension RandomAPIError: Equatable {}

class RandomAPI {
    static func requestString() async throws -> String {
        let url = URL(string: "https://api.stringgy.com/?length=16")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return String(data: data, encoding: .utf8)!
    }
}
