//
//  UserRepo.swift
//  Domain
//
//  Created by Md. Arman Morshed on 1/12/21.
//

import Foundation

public struct UserRepo: Codable, Sendable {
    public var name: String?
    public var descriptionField: String?
    public var url: String?

    public init(name: String?, descriptionField: String?, url: String?) {
        self.name = name
        self.descriptionField = descriptionField
        self.url = url
    }

    enum CodingKeys: String, CodingKey {
        case name, url
        case descriptionField = "description"
    }
}
