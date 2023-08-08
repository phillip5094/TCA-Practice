//
//  Root.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/06
//

import Foundation
import ComposableArchitecture

struct Root: Reducer {
    struct State: Equatable {
        var counter = Counter.State()
        var randomGenerator = RandomGenerator.State()
        var twoButton = TwoButton.State()
        var twoCounter = TwoCounter.State()
        var bakery = Bakery.State()
        var myWebPage = MyWebPage.State()
        var urlEncoder = URLEncoder.State()
    }
    
    enum Action: Equatable {
        case onAppear
        case counter(Counter.Action)
        case randomGenerator(RandomGenerator.Action)
        case twoButton(TwoButton.Action)
        case twoCounter(TwoCounter.Action)
        case bakery(Bakery.Action)
        case myWebPage(MyWebPage.Action)
        case urlEncoder(URLEncoder.Action)
    }
    
    var body: some Reducer<State, Action> {
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
        
        Scope(state: \.bakery, action: /Action.bakery) {
            Bakery()
        }
        
        Scope(state: \.myWebPage, action: /Action.myWebPage) {
            MyWebPage()
        }
        
        Scope(state: \.urlEncoder, action: /Action.urlEncoder) {
            URLEncoder()
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
