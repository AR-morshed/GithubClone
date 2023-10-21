//
//  DIContainer.swift
//  GithubClone
//
//  Created by Arman Morshed on 4/11/22.
//

import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()
    
    private let container: Container = .init()
    let assembler: Assembler
    
    private init() {
        assembler = Assembler(
            [TrendingRepoRepositoryAssembly(),
             TrendingDeveloperAssembly()
            ],
            container: container
        )
    }
    
    func resolve<T>(_ type: T.Type, name: String? = nil) -> T {
        container.resolve(T.self, name: name)!
    }
}
