//
//  RandomGenerator.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/14
//

import Foundation
import ComposableArchitecture

struct RandomGenerator: Reducer {
    struct State: Equatable {
        var randomString: String? = nil
        var proceeding = false
    }
    
    enum Action: Equatable {
        case buttonTapped
        case randomStringResponse(TaskResult<String>)
        case setProceeding(_ flag: Bool)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            return .run { send in
                await send(.setProceeding(true))
                await send(.randomStringResponse(
                    TaskResult { try await
                        RandomAPI.requestString()
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
