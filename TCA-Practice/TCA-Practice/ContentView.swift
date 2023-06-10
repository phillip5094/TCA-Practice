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
                NavigationLink("01_Counter") {
                    CounterView(
                        store: Store(initialState: Counter.State(), reducer: Counter())
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
