//
//  AppError.swift
//  Domain
//
//  Created by Md. Arman Morshed on 1/12/21.
//

import Foundation

public struct AppError: Error, Equatable, Sendable {
    public let code: Int?
    public let title: String?
    public let message: String?

    public init(code: Int?, title: String?, message: String?) {
        self.code = code
        self.title = title
        self.message = message
    }
}
