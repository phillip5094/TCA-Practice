//
//  RandomAPI.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/13
//

import Foundation

// MARK: stringgy
class RandomAPI {
    func requestUUID(length: Int) async throws -> String {
        let url = URL(string: "https://api.stringgy.com/?length=\(length)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return String(data: data, encoding: .utf8)!
    }
}
enum RandomAPIError: Error {
    case unknown
}

extension RandomAPIError: Equatable {}
