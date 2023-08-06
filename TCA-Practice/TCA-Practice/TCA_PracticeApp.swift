//
//  TCA_PracticeApp.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/06/10
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: Root.State()) {
                Root()
            })
        }
    }
}
