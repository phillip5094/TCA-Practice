//
//  MyWebPage.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/26
//

import Foundation
import ComposableArchitecture

struct MyWebPage: Reducer {
    struct State: Equatable {
        var isLoading = true
        var navigationBarTitle = ""
        var canGoBackButtonDisabled = true
        var canGoForwardButtonDisabled = true
        var webView = WebViewReducer.State()
    }
    
    enum Action: Equatable {
        // NavigationBar Action
        case refreshButtonTapped
        case goBackButtonTapped
        case goForwardButtonTapped
        
        // WebView
        case webView(WebViewReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.webView, action: /Action.webView) {
            WebViewReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .refreshButtonTapped:
                state.isLoading = true
                return .run { send in await send(.webView(.refresh)) }
            case .goBackButtonTapped:
                return .run { send in await send(.webView(.goBack)) }
            case .goForwardButtonTapped:
                return .run { send in await send(.webView(.goForward)) }
            case .webView(.titleChanged(let title)):
                state.navigationBarTitle = title
                return .none
            case .webView(.canGoBack(let canGoBack)):
                state.canGoBackButtonDisabled = !canGoBack
                return .none
            case .webView(.canGoForward(let canGoForward)):
                state.canGoForwardButtonDisabled = !canGoForward
                return .none
            case .webView(.didFinishNavigation):
                if state.isLoading {
                    state.isLoading = false
                }
                return .none
            default:
                return .none
            }
        }
    }
}
