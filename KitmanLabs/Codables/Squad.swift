//
//  Squad.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

// MARK: - Squad
struct Squad: Codable, Hashable, Identifiable {
    let createdAt: String
    let id: Int
    let name: String
    let organisationID: Int
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case name
        case organisationID = "organisation_id"
        case updatedAt = "updated_at"
    }
}
