//
//  URLEncoder.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/08/07
//

import Foundation
import ComposableArchitecture

struct URLEncoder: Reducer {
    struct State: Equatable {
        @BindingState var inputString = ""
        var outputString = ""
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case resetButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            // MARK: binding Action
            case .binding(\.$inputString):
                state.outputString = state.inputString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
                return .none
            case .binding:
                return .none
                
            // MARK: feature logic
            case .resetButtonTapped:
                state = State()
                return .none
            }
        }
    }
}
