//
//  TwoCounterView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/09
//

import SwiftUI
import ComposableArchitecture

struct TwoCounterView: View {
    let store: StoreOf<TwoCounter>
    
    var body: some View {
        Form {
            HStack {
                Text("Counter1")
                Spacer()
                CounterView(
                    // 5️⃣ : scope 함수를 사용해서 자식 Reducer를 자식 View에 전달.
                    store: self.store.scope(state: \.counter1, action: TwoCounter.Action.counter1)
                )
            }
            
            HStack {
                Text("Counter2")
                Spacer()
                CounterView(
                    store: Store(initialState: Counter.State(), reducer: Counter()._printChanges())
                )
            }
            
            HStack {
                Text("Reset Counter")
                Spacer()
                Button("OK") {
                    ViewStore(self.store).send(.resetCounter)
                }
            }
        }
        .buttonStyle(.borderless)
    }
}

struct TwoCounterView_Previews: PreviewProvider {
    static var previews: some View {
        TwoCounterView(
            store: Store(initialState: TwoCounter.State(), reducer: TwoCounter())
        )
    }
}
