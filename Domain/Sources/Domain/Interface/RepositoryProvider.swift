//
//  RepositoryProvider.swift
//  Domain
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Foundation

public protocol RepositoryProvider {
    func makeTrendingRepoRepository() -> TrendingRepoRepository
}
