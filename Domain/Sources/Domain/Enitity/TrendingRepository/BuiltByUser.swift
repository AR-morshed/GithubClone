//
//  BuiltByUser.swift
//  Domain
//
//  Created by Md. Arman Morshed on 1/12/21.
//

import Foundation

public struct BuiltByUser: Codable, Sendable {
    public var username: String?
    public var href: String?
    public var avatar: String?

    public init(username: String?, href: String?, avatar: String?) {
        self.username = username
        self.href = href
        self.avatar = avatar
    }

    enum CodingKeys: String, CodingKey {
        case username, href, avatar
    }
}
