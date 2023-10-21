//
//  RepositoryClient.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 3/3/22.
//

import Domain
import Foundation
import NetworkPlatform
import ComposableArchitecture

public struct TrendingRepositoryClient: ClientProtocol {
    private let repositoryUseCase: AnyRepositoryUseCase
    
    @Inject(name: ClientType.live())
    private static var repositoryLiveUseCase: DefaultTrendingRepositoryUseCase
    
    @Inject(name: ClientType.stubbed())
    private static var repositoryStubbedUseCase: DefaultTrendingRepositoryUseCase
    
    public init(trendingRepositoryUseCase: AnyRepositoryUseCase) {
        self.repositoryUseCase = trendingRepositoryUseCase
    }
    
    public func repositoryQueryRequest(query: String) async throws -> [TrendingRepository] {
        return try await repositoryUseCase
            .execute(input: (language: query, since: ""))
    }
    
    struct Failure: Error, Equatable {}
}

extension TrendingRepositoryClient {
    // MARK: - Live API implementation
    static let live = TrendingRepositoryClient(trendingRepositoryUseCase: AnyRepositoryUseCase(with: repositoryLiveUseCase))
    
    // MARK: - Mock API implementations
    static let stubbed = TrendingRepositoryClient(trendingRepositoryUseCase: AnyRepositoryUseCase(with: repositoryStubbedUseCase))
}

extension DependencyValues {
    public var trendingRepositoryClient: TrendingRepositoryClient {
        get { self[TrendingRepositoryClient.self] }
        set { self[TrendingRepositoryClient.self] = newValue }
    }
}

extension TrendingRepositoryClient: DependencyKey {
    public static var liveValue = TrendingRepositoryClient.live
    public static var testValue = TrendingRepositoryClient.stubbed
    public static var previewValue = TrendingRepositoryClient.stubbed
}
