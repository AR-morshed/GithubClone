//
//  TrendingDeveloperUseCase.swift
//  Domain
//
//  Created by Rokon on 6/29/22.
//

import Combine
import Foundation

public typealias AnyDeveloperUseCase = AnyUsecase<(language: String, since: String), [TrendingUser]>

public final class DefaultTrendingDeveloperUseCase: UseCase {
    private let repository: TrendingDeveloperRepository

    public init(repository: TrendingDeveloperRepository) {
        self.repository = repository
    }

    public func execute(input: (language: String, since: String)) async throws -> [TrendingUser] {
        return try await repository.trendingDeveloper(language: input.language, since: input.since)
    }
}
