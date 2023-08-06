//
//  BakingMachine.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/12
//

import Foundation
import ComposableArchitecture

struct BakingMachine: Reducer {
    struct State: Equatable {
        var running = false
    }
    
    enum Action: Equatable {
        case buttonTapped
        case setRunning(Bool)
        case startBaking
        case finishBaking        
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            return .run { send in
                await send(.setRunning(false))
                await send(.finishBaking)
            }
        case let .setRunning(running):
            state.running = running
            return .none
        case .startBaking:
            print("[BakingMachine] 빵 만들자.")
            return .run { send in await send(.setRunning(true)) }
        case .finishBaking:
            print("[BakingMachine] 빵 다 만들었다.")
            return .none
        }
    }
}
