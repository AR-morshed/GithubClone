//
//  TrendingDetailsFeature.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 23/3/22.
//

import ComposableArchitecture
import Domain
import Foundation
import SwiftUI

public struct TrendingDetailsFeature: ReducerProtocol {
    
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        public var alert: AlertState<Action>?
        var isFev: Bool = false
        public var trendingRepository: TrendingRepository?
    }

    public enum Action: Equatable {
        case alertDismissed
        case onAppear
        case onFevButtonTap
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .alertDismissed:
            return .none
        case .onAppear:
            return .none
        case .onFevButtonTap:
            state.isFev = !state.isFev
        }
        return .none
    }
}
