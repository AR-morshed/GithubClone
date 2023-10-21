//
//  TrendingRepoRepository.swift
//  Domain
//
//  Created by Rokon on 6/29/22.
//

import Combine
import Foundation

public protocol TrendingRepoRepository {
    func trendingRepositories(language: String, since: String) async throws -> [TrendingRepository]
}
