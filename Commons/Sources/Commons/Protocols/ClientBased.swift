//
//  ClientBased.swift
//  GithubClone
//
//  Created by Rokon Uddin on 11/7/22.
//

import Foundation
import ComposableArchitecture

public protocol ClientProtocol {
    
}

public protocol ClientBased {
    associatedtype Client:ClientProtocol
    var client: Client { get }
}
