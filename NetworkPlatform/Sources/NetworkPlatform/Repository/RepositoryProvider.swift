//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Domain
import Foundation

public struct RepositoryProvider: Domain.RepositoryProvider {
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeTrendingRepoRepository() -> Domain.TrendingRepoRepository {
        return TrendingRepoRepository(network: networkProvider.makeTrendingGithubNetworking())
    }

    public func makeTrendingDeveloperRepository() -> Domain.TrendingDeveloperRepository {
        return TrendingDeveloperRepository(network: networkProvider.makeTrendingGithubNetworking())
    }

    public func makeTrendingRepoRepositoryStubbed() -> Domain.TrendingRepoRepository {
        return TrendingRepoRepository(network: networkProvider.makeTrendingGithubNetworkingStubbed())
    }

    public func makeTrendingDeveloperRepositoryStubbed() -> Domain.TrendingDeveloperRepository {
        return TrendingDeveloperRepository(network: networkProvider.makeTrendingGithubNetworkingStubbed())
    }
}
