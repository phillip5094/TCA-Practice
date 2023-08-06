//
//  WebViewReducer.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/20
//

import Foundation
import ComposableArchitecture

struct WebViewReducer: Reducer {
    struct State: Equatable {
        fileprivate weak var webViewController: WebViewController?
    }
    
    enum Action: Equatable {
        case setWebViewController(WebViewController)
        case refresh
        case canGoBack(Bool)
        case canGoForward(Bool)
        case goBack
        case goForward
        case titleChanged(String)
        case urlChanged(URL)
        case decidePolicyForNavigationAction
        case decidePolicyForNavigationResponse
        case didFinishNavigation
        case didFailNaviation
        case didFailProvisionalNavigation
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .setWebViewController(webViewController):
            state.webViewController = webViewController
            return .none
        case .refresh:
            state.webViewController?.refresh()
            return .none
        case .goBack:
            state.webViewController?.goBack()
            return .none
        case .goForward:
            state.webViewController?.goForward()
            return .none
        default:
            return .none
        }
    }
}
