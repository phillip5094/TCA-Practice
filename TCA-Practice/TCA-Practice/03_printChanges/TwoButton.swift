//
//  TwoButton.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/24
//

import Foundation
import ComposableArchitecture

struct TwoButton: Reducer {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action: Equatable {
        case increaseCount
        case innerAction
        case doSomething
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .increaseCount:
            state.count += 1
            return .none
        case .innerAction:
            return .run { send in await send(.doSomething) }
        case .doSomething:
            return .none
        }
    }
}
