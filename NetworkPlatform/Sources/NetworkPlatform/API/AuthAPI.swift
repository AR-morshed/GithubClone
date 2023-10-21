//
//  AuthAPI.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 25/11/21.
//

import Foundation
import Moya

enum AuthAPI {
    case accessToken
}

extension AuthAPI: TargetType, ProductAPIType, Stubbable {
    var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/token")!
    }

    var path: String {
        switch self {
        case .accessToken:
            return "/access_token"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .accessToken:
            return stubbedResponse("AccessToken")
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
}
