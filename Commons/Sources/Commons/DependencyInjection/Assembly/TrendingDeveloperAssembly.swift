//
//  TrendingDeveloperAssembly.swift
//  GithubClone
//
//  Created by Arman Morshed on 4/11/22.
//

import Foundation
import Swinject
import Domain
import NetworkPlatform

class TrendingDeveloperAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TrendingDeveloperRepository.self, name: ClientType.live()) { _ in
            NetworkPlatform.RepositoryProvider().makeTrendingDeveloperRepository()
        }
        .inObjectScope(.container)
        
        container.register(TrendingDeveloperRepository.self, name: ClientType.stubbed()) { _ in
            NetworkPlatform.RepositoryProvider().makeTrendingDeveloperRepositoryStubbed()
        }
        .inObjectScope(.container)
        
        container.register(DefaultTrendingDeveloperUseCase.self, name: ClientType.live()) { resolver in
            DefaultTrendingDeveloperUseCase(repository: resolver.resolve(TrendingDeveloperRepository.self,
                                                                 name: ClientType.live())!)
        }
        .inObjectScope(.container)
        
        container.register(DefaultTrendingDeveloperUseCase.self, name: ClientType.stubbed()) { resolver in
            DefaultTrendingDeveloperUseCase(repository: resolver.resolve(TrendingDeveloperRepository.self,
                                                                 name: ClientType.stubbed())!)
        }
        .inObjectScope(.container)
    }
}
