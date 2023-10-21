//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Foundation

final class NetworkProvider {
    public func makeTrendingGithubNetworking() -> TrendingGithubNetworking {
        return TrendingGithubNetworking.defaultNetworking()
    }

    public func makeTrendingGithubNetworkingStubbed() -> TrendingGithubNetworking {
        return TrendingGithubNetworking.stubbingNetworking()
    }
}
