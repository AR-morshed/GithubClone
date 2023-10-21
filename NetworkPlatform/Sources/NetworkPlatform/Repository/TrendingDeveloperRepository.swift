//
//  TrendingDeveloperRepository.swift
//  NetworkPlatform
//
//  Created by Rokon on 6/29/22.
//

import Combine
import Domain

struct TrendingDeveloperRepository: Domain.TrendingDeveloperRepository {
    private let network: TrendingGithubNetworking

    init(network: TrendingGithubNetworking) {
        self.network = network
    }

    func trendingDeveloper(language: String, since: String) async throws -> [TrendingUser] {
        return try await network.trendingDevelopers(language: language, since: since)
    }
}
