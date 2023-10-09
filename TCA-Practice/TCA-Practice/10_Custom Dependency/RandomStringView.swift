//
//  RandomStringView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/10/03
//

import SwiftUI
import ComposableArchitecture

struct RandomStringView: View {
    let store: StoreOf<RandomString>
    
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
    }
}

struct RandomStringView_Previews: PreviewProvider {
    static var previews: some View {
        RandomStringView(
            store: .init(initialState: RandomString.State()) {
                RandomString()
            }
        )
    }
}
