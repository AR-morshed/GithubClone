//
//  RootFeature.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 21/2/22.
//

import TrendingDetails
import TrendingRepository
import ComposableArchitecture

public struct Root: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var trendingRepositoryState = TrendingRepositoryFeature.State()
    }

    public enum Action: Equatable {
        case trendingRepositoryAction(TrendingRepositoryFeature.Action)
    }

    public var body: some Reducer<State, Action> {
        Scope(state: \.trendingRepositoryState, action: /Action.trendingRepositoryAction) {
            TrendingRepositoryFeature()
        }
    }
}
