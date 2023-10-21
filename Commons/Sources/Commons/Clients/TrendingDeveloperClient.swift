//
//  TrendingDeveloperClient.swift
//  GithubClone
//
//  Created by Rokon Uddin on 11/8/22.
//

import Domain
import Foundation
import NetworkPlatform
import ComposableArchitecture

public struct TrendingDeveloperClient: ClientProtocol {
    private let developerUseCase: AnyDeveloperUseCase
    
    @Inject(name: ClientType.live())
    private static var developerLiveUseCase: DefaultTrendingDeveloperUseCase
    
    @Inject(name: ClientType.stubbed())
    private static var developerStubbedUseCase: DefaultTrendingDeveloperUseCase
    
    public init(trendingDeveloperUseCase: AnyDeveloperUseCase) {
        self.developerUseCase = trendingDeveloperUseCase
    }
    
    public func userQueryRequest(query: String) async throws -> [TrendingUser] {
        return try await developerUseCase
            .execute(input: (language: query, since: ""))
    }
    
    struct Failure: Error, Equatable {}
}

extension TrendingDeveloperClient {
    
    // MARK: - Live API implementation
    static let live = TrendingDeveloperClient(trendingDeveloperUseCase: AnyDeveloperUseCase(with: developerLiveUseCase))
    
    // MARK: - Mock API implementations
    static let stubbed = TrendingDeveloperClient(trendingDeveloperUseCase: AnyDeveloperUseCase(with: developerStubbedUseCase))
}

extension DependencyValues {
    public var trendingDeveloperClient: TrendingDeveloperClient {
        get { self[TrendingDeveloperClient.self] }
        set { self[TrendingDeveloperClient.self] = newValue }
    }
}

extension TrendingDeveloperClient: DependencyKey {
    public static var liveValue = TrendingDeveloperClient.live
    public static var testValue = TrendingDeveloperClient.stubbed
    public static var previewValue = TrendingDeveloperClient.stubbed
}
