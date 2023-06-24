//
//  RandomGeneratorView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/14
//

import SwiftUI
import ComposableArchitecture

struct RandomGeneratorView: View {
    let store: StoreOf<RandomGenerator>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if viewStore.proceeding {
                    ProgressView()
                } else {
                    Text(viewStore.randomString ?? "")
                }
                
                Button("Generate Random String!") {
                    viewStore.send(.buttonTapped)
                }
            }
        }
        ._printChanges("Philip")
    }
}

struct RandomGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        RandomGeneratorView(store: .init(initialState: RandomGenerator.State(), reducer: RandomGenerator()))
    }
}
