//
//  TrendingRepoRepositoryAssembly.swift
//  GithubClone
//
//  Created by Arman Morshed on 4/11/22.
//

import Foundation
import Swinject
import Domain
import NetworkPlatform

class TrendingRepoRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TrendingRepoRepository.self, name: ClientType.live()) { _ in
            NetworkPlatform.RepositoryProvider().makeTrendingRepoRepository()
        }
        .inObjectScope(.container)
        
        container.register(TrendingRepoRepository.self, name: ClientType.stubbed()) { _ in
            NetworkPlatform.RepositoryProvider().makeTrendingRepoRepositoryStubbed()
        }
        .inObjectScope(.container)
        
        container.register(DefaultTrendingRepositoryUseCase.self, name: ClientType.live()) { resolver in
            DefaultTrendingRepositoryUseCase(repository: resolver.resolve(TrendingRepoRepository.self,
                                                                          name: ClientType.live())!)
        }
        .inObjectScope(.container)
        
        container.register(DefaultTrendingRepositoryUseCase.self, name: ClientType.stubbed()) { resolver in
            DefaultTrendingRepositoryUseCase(repository: resolver.resolve(TrendingRepoRepository.self,
                                                                          name: ClientType.stubbed())!)
        }
        .inObjectScope(.container)
    }
}
