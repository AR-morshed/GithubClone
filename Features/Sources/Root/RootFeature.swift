//
//  RootFeature.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 21/2/22.
//

import AppSetting
import Authentication
import TrendingDetails
import TrendingDeveloper
import TrendingRepository
import ComposableArchitecture

public struct Root: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        var authenticationState = AuthenticationFeature.State()
        var trendingRepositoryState = TrendingRepositoryFeature.State()
        var trendingDevelopersState = TrendingDevelopersFeature.State()
        var settingState = AppSettingFeature.State()
    }

    public enum Action: Equatable {
        case authenticationAction(AuthenticationFeature.Action)
        case trendingRepositoryAction(TrendingRepositoryFeature.Action)
        case trendingDevelopersAction(TrendingDevelopersFeature.Action)
        case appSettingAction(AppSettingFeature.Action)
    }

    public var body: some Reducer<State, Action> {
        Scope(state: \.authenticationState, action: /Action.authenticationAction) {
            AuthenticationFeature()
        }

        Scope(state: \.trendingRepositoryState, action: /Action.trendingRepositoryAction) {
            TrendingRepositoryFeature()
        }

        Scope(state: \.trendingDevelopersState, action: /Action.trendingDevelopersAction) {
            TrendingDevelopersFeature()
        }

        Scope(state: \.settingState, action: /Action.appSettingAction) {
            AppSettingFeature()
        }
    }
}
