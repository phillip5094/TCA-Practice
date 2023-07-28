//
//  MyWebPageView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/26
//

import SwiftUI
import ComposableArchitecture

struct MyWebPageView: View {
    let store: StoreOf<MyWebPage>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                ZStack {
                    WebView(
                        url: URL(string: "https://phillip5094.tistory.com/")!,
                        store: store.scope(state: \.webView, action: MyWebPage.Action.webView)
                    )
                    
                    if viewStore.isLoading {
                        ProgressView()
                    }
                }
                .navigationTitle(viewStore.navigationBarTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            viewStore.send(.goBackButtonTapped)
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        .disabled(viewStore.canGoBackButtonDisabled)
                        
                        Button {
                            viewStore.send(.goForwardButtonTapped)
                        } label: {
                            Image(systemName: "chevron.forward")
                        }
                        .disabled(viewStore.canGoForwardButtonDisabled)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewStore.send(.refreshButtonTapped)
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
    }
}

struct MyWebPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyWebPageView(
            store: Store(initialState: MyWebPage.State(), reducer: MyWebPage())
        )
    }
}
