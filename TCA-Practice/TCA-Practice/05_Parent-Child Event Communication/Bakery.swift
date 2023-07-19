//
//  Bakery.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/12
//

import Foundation
import ComposableArchitecture

struct Bakery: ReducerProtocol {
    struct State: Equatable {
        var baking = false
        var numberOfBread = 0
        var bakingMachine = BakingMachine.State()
    }
    
    enum Action: Equatable {
        case buttonTapped
        case setBaking(Bool)
        case increaseNumberOfBread
        case bakingMachine(BakingMachine.Action)
    }

    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.bakingMachine, action: /Action.bakingMachine) {
            BakingMachine()
        }
        
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                return .run { send in
                    await send(.setBaking(true))
                    print("[Bakery] 빵 만들어랏.")
                    await send(.bakingMachine(.startBaking))
                }
            case let .setBaking(baking):
                state.baking = baking
                return .none
            case .increaseNumberOfBread:
                state.numberOfBread += 1
                return .none
            case .bakingMachine(.finishBaking):
                print("[Bakery] 빵 다 만들었대!!")
                return .run { send in
                    await send(.setBaking(false))
                    await send(.increaseNumberOfBread)
                }
            default:
                return .none
            }
        }
    }
}
