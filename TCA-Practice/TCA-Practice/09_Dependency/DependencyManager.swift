//
//  DependencyManager.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/09/26
//

import Foundation
import ComposableArchitecture

struct DependencyManager: Reducer {
    struct State: Equatable {
        var currentDate: Date?
        var uuid: String = ""
        var uuid2: String = ""
    }
    
    enum Action: Equatable {
        case currentDateButtonTapped
        case generateUUIDButtonTapped
        case generateUUIDAfter1SecondsButtonTapped
        case setUUID2
    }
    
    @Dependency(\.date.now) var now             // ✅ Controllable way to ask for current date
    @Dependency(\.uuid) var uuid                // ✅ Controllable UUID creation
    @Dependency(\.continuousClock) var clock    // ✅ Controllable way to sleep a task
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .currentDateButtonTapped:
            state.currentDate = now     // ✅ date.now로 현재 시간 정보 가져옴.
            return .none
        case .generateUUIDButtonTapped:
            state.uuid = uuid().uuidString  // ✅ uuid로 uuid 생성
            return .none
        case .generateUUIDAfter1SecondsButtonTapped:
            return .run { send in
                try await clock.sleep(for: .seconds(1)) // ✅ clock을 사용해서 1초 sleep
                await send(.setUUID2)
            }
        case .setUUID2:
            state.uuid2 = uuid().uuidString
            return .none
        }
    }
}
