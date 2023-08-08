//
//  URLEncoderView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/08/07
//

import SwiftUI
import ComposableArchitecture

struct URLEncoderView: View {
    let store: StoreOf<URLEncoder>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                VStack(alignment: .leading) {
                    Text("URL Encoder")
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    Group {
                        Text("Input")
                        TextField("인코딩할 문자열을 입력하세요.", text: viewStore.$inputString)
                            .padding(5)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .frame(height: 100)
                            .border(.secondary)
                    }

                    Group {
                        Text("Output")
                        Text(viewStore.outputString)
                            .padding(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 100)
                            .border(.secondary)
                    }
                }
                .padding()
                
                Button("Reset") {
                    viewStore.send(.resetButtonTapped)
                }
                .buttonStyle(.bordered)
                .padding(.bottom)
            }
        }
    }
}

struct URLEncoderView_Previews: PreviewProvider {
    static var previews: some View {
        URLEncoderView(
            store: Store(initialState: .init()) {
                URLEncoder()
            }
        )
    }
}
