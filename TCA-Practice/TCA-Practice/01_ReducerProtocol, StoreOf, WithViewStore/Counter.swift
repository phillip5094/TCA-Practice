//
//  Counter.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/10
//

import Foundation
import ComposableArchitecture

struct Counter: Reducer {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action: Equatable {
        case increaseButtonTapped
        case decreaseButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .increaseButtonTapped:
            state.count += 1
            return .none
        case .decreaseButtonTapped:
            state.count -= 1
            return .none
        }
    }
}
