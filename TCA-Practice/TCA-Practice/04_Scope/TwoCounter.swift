//
//  TwoCounter.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/09
//

import Foundation
import ComposableArchitecture

struct TwoCounter: Reducer {
    struct State: Equatable {
        // 1️⃣ : 자식 State를 부모 State에 포함.
        var counter1 = Counter.State()
    }
    
    enum Action: Equatable {
        case resetCounter
        // 2️⃣ : 부모 Action에 자식 Action을 포함.
        case counter1(Counter.Action)
    }
    
    var body: some Reducer<State, Action> {
        /*
         3️⃣ : body 프로퍼티 안에 Scope를 사용해서 자식 Reducer 정의.
         (State.counter1을 state로 가지고, Counter.Action을 action으로 가진 자식 Reducer)
         */
        Scope(state: \.counter1, action: /Action.counter1) {
            Counter()
                ._printChanges()
        }
        
        // 4️⃣ : 부모가 Action을 받았을 때의 비즈니스 로직 구현
        Reduce { state, action in
            switch action {
            case .resetCounter:
                state.counter1 = .init()
                return .none
            default:
                return .none
            }
        }
        ._printChanges()
    }
}
