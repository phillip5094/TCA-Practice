//
//  BakingMachineView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/12
//

import SwiftUI
import ComposableArchitecture

struct BakingMachineView: View {
    let store: StoreOf<BakingMachine>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("제빵기 입니다.")
                Button("빵 다 만들었어욥") {
                    viewStore.send(.buttonTapped)
                }
                .disabled(!viewStore.running)
                .buttonStyle(.bordered)
            }
        }
    }
}

struct BakingMachineView_Previews: PreviewProvider {
    static var previews: some View {
        BakingMachineView(
            store: Store(initialState: BakingMachine.State()) {
                BakingMachine()
            }
        )
    }
}
