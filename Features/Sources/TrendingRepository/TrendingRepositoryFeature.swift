//
//  TrendingRepositoryTCA.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 3/2/22.
//

import Domain
import Commons
import SwiftUI
import Foundation
import TrendingDetails
import ComposableArchitecture

public struct TrendingRepositoryFeature: ClientFeatureBased {
    
    public init() {}
    
    @Dependency(\.trendingRepositoryClient) public var client

    public struct State: Equatable {
        
        public init() {}
        
        var searchState = SearchFeature.State()
        var trendingDetailsState = TrendingDetailsFeature.State()
        var alert: AlertState<Action>?
        var isLoadingRepositoryView: Bool = true
        var trendingRepositories: [TrendingRepository] = []
        var tempTrendingRepositories: [TrendingRepository] = []
    }

    public enum Action: Equatable {
        case search(SearchFeature.Action)
        case details(TrendingDetailsFeature.Action)
        case presentDetails(TrendingRepository)
        case alertDismissed
        case onAppear
        case repositoryResponse(TaskResult<[TrendingRepository]>)
    }

    public var body: some Reducer<State, Action> {
        Scope(state: \.searchState, action: /Action.search) {
            SearchFeature()
        }

        Scope(state: \.trendingDetailsState, action: /Action.details) {
            TrendingDetailsFeature()
        }

        Reduce { state, action in
            switch action {
            case .alertDismissed:
                state.alert = nil

            case .onAppear:
                state.isLoadingRepositoryView = true
                return .run { send in
                    await send(.repositoryResponse(TaskResult {
                        try await client.repositoryQueryRequest(query: "swift")
                    }))
                }

            case let .repositoryResponse(.success(repositories)):
                state.isLoadingRepositoryView = false
                state.trendingRepositories = repositories
                return .none

            case let .repositoryResponse(.failure(error)):
                state.alert = .init(title: TextState(error.localizedDescription))
                return .none

            case let .search(.searchQueryChanged(query)):
                struct SearchLocationId: Hashable {}

                if state.tempTrendingRepositories.count == 0 {
                    state.tempTrendingRepositories = state.trendingRepositories
                }

                guard !query.isEmpty
                else {
                    state.trendingRepositories = state.tempTrendingRepositories
                    return .cancel(id: SearchLocationId())
                }

                state.isLoadingRepositoryView = true

                return .run { send in
                    await send(.repositoryResponse(TaskResult {
                        try await client.repositoryQueryRequest(query: query)
                    }))
                }

            case .search, .details:
                return .none
            case let .presentDetails(item):
                state.trendingDetailsState.trendingRepository = item
            }

            return .none
        }
    }
}
