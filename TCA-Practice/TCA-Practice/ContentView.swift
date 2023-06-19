//
//  ContentView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/10
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("01_ReducerProtocol, StoreOf, WithViewStore") {
                    CounterView(
                        store: Store(initialState: Counter.State(), reducer: Counter())
                    )
                }
                
                NavigationLink("02_TaskResult, run") {
                    RandomGeneratorView(
                        store: .init(initialState: RandomGenerator.State(), reducer: RandomGenerator())
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
