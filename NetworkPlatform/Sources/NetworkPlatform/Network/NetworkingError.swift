//
//  NetworkingError.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 25/11/21.
//

import Foundation

enum NetworkingError: Error {
    case error(String)
    case defaultError

    var message: String {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "Please try again later."
        }
    }
}
