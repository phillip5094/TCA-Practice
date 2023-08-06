//
//  BakeryView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/12
//

import SwiftUI
import ComposableArchitecture

struct BakeryView: View {
    let store: StoreOf<Bakery>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                VStack {
                    Text("빵 가게 입니다.")
                    
                    Text("빵 재고: \(viewStore.numberOfBread)")
                    
                    Button("빵 만들어랏") {
                        viewStore.send(.buttonTapped)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                    if viewStore.baking {
                        ProgressView {
                            Text("빵 굽는 중")
                        }
                        .padding()
                    }
                }
                
                BakingMachineView(
                    store: self.store.scope(state: \.bakingMachine, action: Bakery.Action.bakingMachine)
                )
            }
        }
    }
}

struct BakeryView_Previews: PreviewProvider {
    static var previews: some View {
        BakeryView(
            store: Store(initialState: .init()) {
                Bakery()
            }
        )
    }
}
