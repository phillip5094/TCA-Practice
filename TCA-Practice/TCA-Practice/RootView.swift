//
//  RootView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/10
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<Root>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("01_ReducerProtocol, StoreOf, WithViewStore") {
                    CounterView(
                        store: self.store.scope(state: \.counter, action: Root.Action.counter)
                    )
                    .navigationTitle("Counter")
                }
                
                NavigationLink("02_TaskResult, run") {
                    RandomGeneratorView(
                        store: self.store.scope(state: \.randomGenerator, action: Root.Action.randomGenerator)
                    )
                    .navigationTitle("Random Generator")
                }
                
                NavigationLink("03_printChanges") {
                    TwoButtonView(
                        store: self.store.scope(state: \.twoButton, action: Root.Action.twoButton)
                    )
                    .navigationTitle("Two Button")
                }
                
                NavigationLink("04_Scope") {
                    TwoCounterView(
                        store: self.store.scope(state: \.twoCounter, action: Root.Action.twoCounter)
                    )
                    .navigationTitle("Two Counter")
                }
                
                NavigationLink("05_Parent-Child Event Communication") {
                    BakeryView(
                        store: self.store.scope(state: \.bakery, action: Root.Action.bakery)
                    )
                    .navigationTitle("Parent-Child Event Communication")
                }
            }
            .onAppear { ViewStore(self.store).send(.onAppear) }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: .init(initialState: Root.State(), reducer: Root()))
    }
}
