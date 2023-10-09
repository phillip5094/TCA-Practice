//
//  NumbersAPIClient.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/10/03
//

import Foundation
import Dependencies

protocol NumbersAPI {
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String
}

// MARK: - liveValue
class NumbersAPIClient: NumbersAPI {
    enum Category: String {
        case trivia = "trivia"
        case math = "math"
        case date = "date"
        case year = "year"
    }
    
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String {
        let url = URL(string: "http://numbersapi.com/random/\(category)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        return String(data: data, encoding: .utf8)!
    }
}

// MARK: - previewValue
class PreviewNumbersAPIClient: NumbersAPI {
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String {
        return "requestNumbersAPI preview"
    }
}

// MARK: - testValue
class TestNumbersAPIClient: NumbersAPI {
    func requestNumbersAPI(category: NumbersAPIClient.Category) async throws -> String {
        return "requestNumbersAPI test"
    }
}

private enum NumbersAPIClientKey: DependencyKey {
    static var liveValue: NumbersAPI = NumbersAPIClient()
    static var previewValue: NumbersAPI = PreviewNumbersAPIClient()
    static var testValue: NumbersAPI = TestNumbersAPIClient()
}

extension DependencyValues {
    var numbersAPIClient: NumbersAPI {
        get { self[NumbersAPIClientKey.self] }
        set { self[NumbersAPIClientKey.self] = newValue }
    }
}
