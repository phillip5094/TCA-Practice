//
//  CounterView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/10
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<Counter>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 20) {
                Button("-") {
                    viewStore.send(.decreaseButtonTapped)
                }
                
                Text("\(viewStore.count)")
                
                Button("+") {
                    viewStore.send(.increaseButtonTapped)
                }
            }
            .scaleEffect(1.5)
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialState: Counter.State(), reducer: Counter())
        )
    }
}
