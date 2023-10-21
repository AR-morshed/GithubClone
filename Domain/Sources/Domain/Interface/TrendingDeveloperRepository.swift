//
//  TrendingDeveloperRepository.swift
//  Domain
//
//  Created by Rokon on 6/29/22.
//

import Combine
import Foundation

public protocol TrendingDeveloperRepository {
    func trendingDeveloper(language: String, since: String) async throws -> [TrendingUser]
}
