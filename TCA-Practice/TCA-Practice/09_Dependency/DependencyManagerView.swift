//
//  DependencyManagerView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/09/26
//

import SwiftUI
import ComposableArchitecture

struct DependencyManagerView: View {
    let store: StoreOf<DependencyManager>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 30) {
                HStack {
                    Button("Current Date") {
                        viewStore.send(.currentDateButtonTapped)
                    }
                    .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    
                    if let date = viewStore.currentDate {
                        Text("\(date)")
                    }
                }
                
                HStack {
                    Button("Generate UUID") {
                        viewStore.send(.generateUUIDButtonTapped)
                    }
                    .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    
                    Text(viewStore.uuid)
                }
                
                HStack {
                    Button("Generate UUID after 1 seconds") {
                        viewStore.send(.generateUUIDAfter1SecondsButtonTapped)
                    }
                    .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    
                    Text(viewStore.uuid2)
                }
            }
            .frame(width: 300)
        }
        .font(.system(size: 13))
    }
}

var uuidCount = 0

struct DependencyManagerView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyManagerView(
            store: Store(
                initialState: DependencyManager.State()) {
                    DependencyManager()
//                        .dependency(\.uuid, UUIDGenerator({     // ✅ dependency 수식어로 모듈 교체
//                            uuidCount += 1
//                            return UUID(uuidCount)
//                        }))
                }
        )
    }
}
