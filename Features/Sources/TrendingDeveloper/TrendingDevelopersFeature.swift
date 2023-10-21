//
//  TrendingDevelopersTCA.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 21/2/22.
//

import Domain
import Commons
import Foundation
import ComposableArchitecture

public struct TrendingDevelopersFeature: ClientFeatureBased {
    @Dependency(\.trendingDeveloperClient) public var client
    
    public init() {}

    public struct State: Equatable {
        public init() {}
        public var alert: AlertState<Action>?
        var isLoadingDeveloperView: Bool = false
        var trendingUsers: [TrendingUser] = []
    }

    public enum Action: Equatable {
        case alertDismissed
        case onAppear
        case repositoryResponse(TaskResult<[TrendingUser]>)
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.isLoadingDeveloperView = true
            return .task {
                await .repositoryResponse(TaskResult {
                    try await client.userQueryRequest(query: "swift")
                })
            }

        case let .repositoryResponse(.success(users)):
            state.isLoadingDeveloperView = false
            state.trendingUsers = users
            return .none

        case let .repositoryResponse(.failure(error)):
            state.alert = .init(title: TextState(error.localizedDescription))
            return .none

        case .alertDismissed:
            break
        }
        return .none
    }
}
