//
//  Enum+Functionable.swift
//  GithubClone
//
//  Created by Rokon Uddin on 11/7/22.
//

import Foundation

protocol Functionable {
    associatedtype Element
    func callAsFunction() -> Element
}

extension Functionable where Self: RawRepresentable {
    func callAsFunction() -> Self.RawValue {
        return rawValue
    }
}
