//
//  TwoButtonView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/24
//

import SwiftUI
import ComposableArchitecture

struct TwoButtonView: View {
    let store: StoreOf<TwoButton>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                Button("Increase Count") {
                    viewStore.send(.increaseCount)
                }
                Button("Inner Action") {
                    viewStore.send(.innerAction)
                }
            }
        }
        ._printChanges()
    }
}

struct TwoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TwoButtonView(store: .init(initialState: TwoButton.State(), reducer: TwoButton()._printChanges()))
    }
}
