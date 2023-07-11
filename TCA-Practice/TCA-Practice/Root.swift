//
//  Root.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/06
//

import Foundation
import ComposableArchitecture

struct Root: ReducerProtocol {
    struct State: Equatable {
        var counter = Counter.State()
        var randomGenerator = RandomGenerator.State()
        var twoButton = TwoButton.State()
        var twoCounter = TwoCounter.State()
    }
    
    enum Action: Equatable {
        case onAppear
        case counter(Counter.Action)
        case randomGenerator(RandomGenerator.Action)
        case twoButton(TwoButton.Action)
        case twoCounter(TwoCounter.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.counter, action: /Action.counter) {
            Counter()
        }
        
        Scope(state: \.randomGenerator, action: /Action.randomGenerator) {
            RandomGenerator()
        }
        
        Scope(state: \.twoButton, action: /Action.twoButton) {
            TwoButton()
        }
        
        Scope(state: \.twoCounter, action: /Action.twoCounter) {
            TwoCounter()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
                return .none
            default:
                return .none
            }
        }
        ._printChanges()
    }
}
