//
//  Inject.swift
//  GithubClone
//
//  Created by Arman Morshed on 4/11/22.
//

import Foundation

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init(name: String? = nil) {
        self.wrappedValue = DIContainer.shared.resolve(I.self, name: name)
    }
}
