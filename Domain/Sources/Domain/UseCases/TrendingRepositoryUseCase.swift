//
//  TrendingRepositoryUseCase.swift
//  Domain
//
//  Created by Md. Arman Morshed on 23/11/21.
//

import Combine
import Foundation

public typealias AnyRepositoryUseCase = AnyUsecase<(language: String, since: String), [TrendingRepository]>

public final class DefaultTrendingRepositoryUseCase: UseCase {
    private let repository: TrendingRepoRepository

    public init(repository: TrendingRepoRepository) {
        self.repository = repository
    }

    public func execute(input: (language: String, since: String)) async throws -> [TrendingRepository] {
        return try await repository.trendingRepositories(language: input.language, since: input.since)
    }
}

//extension DefaultTrendingRepositoryUseCase {
//    static let live = DefaultTrendingRepositoryUseCase(repository: RepositoryProvider().makeTrendingRepoRepository())
//}

//extension DependencyValues {
//    public var defaultTrendingRepositoryUseCase: DefaultTrendingRepositoryUseCase {
//        get { self[DefaultTrendingRepositoryUseCase.self] }
//        set { self[DefaultTrendingRepositoryUseCase.self] = newValue }
//    }
//}
//
//extension DefaultTrendingRepositoryUseCase: DependencyKey {
//    public static var liveValue =
//    public static var testValue = TrendingRepositoryClient.stubbed
//    public static var previewValue = TrendingRepositoryClient.stubbed
//}
