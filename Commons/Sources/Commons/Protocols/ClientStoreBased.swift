//
//  ClientStoreBased.swift
//  GithubClone
//
//  Created by Rokon Uddin on 11/8/22.
//

import SwiftUI
import ComposableArchitecture

public typealias ClientFeatureBased = ReducerProtocol & ClientBased

public protocol StoreBased where Self: View {
    associatedtype Feature: ReducerProtocol
    var store: StoreOf<Feature> { get }
}

public protocol ClientStoreBased where Self: View {
    associatedtype Feature: ClientFeatureBased
    var store: StoreOf<Feature> { get }
}
