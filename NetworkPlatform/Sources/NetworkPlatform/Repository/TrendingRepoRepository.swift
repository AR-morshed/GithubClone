//
//  TrendingGithubUseCase.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Combine
import Domain

struct TrendingRepoRepository: Domain.TrendingRepoRepository {
    private let network: TrendingGithubNetworking

    init(network: TrendingGithubNetworking) {
        self.network = network
    }

    func trendingRepositories(language: String, since: String) async throws -> [TrendingRepository] {
        return try await network.trendingRepositories(language: language, since: since)
    }
}
