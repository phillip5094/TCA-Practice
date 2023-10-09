//
//  RandomString.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/10/03
//

import Foundation
import ComposableArchitecture

struct RandomString: Reducer {
    struct State: Equatable {
        var randomString: String? = nil
        var proceeding = false
    }
    
    enum Action: Equatable {
        case buttonTapped
        case randomStringResponse(TaskResult<String>)
        case setProceeding(_ flag: Bool)
    }
    
    @Dependency(\.numbersAPIClient) var numbersAPIClient    // ✅ 사용자 정의 모듈 의존성 주입
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            return .run { send in
                await send(.setProceeding(true))
                await send(.randomStringResponse(
                    TaskResult { try await
                        numbersAPIClient.requestNumbersAPI(category: .year)
                    })
                )
                await send(.setProceeding(false))
            }
        case let .randomStringResponse(.success(response)):
            state.randomString = response
            return .none
        case .randomStringResponse(.failure):
            state.randomString = "Error!"
            return .none
        case let .setProceeding(flag):
            state.proceeding = flag
            return .none
        }
    }
}

