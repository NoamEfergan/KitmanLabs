//
//  Athlete.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

// MARK: - Athlete
struct Athlete: Codable, Hashable, Identifiable {
    let firstName, lastName: String
    let id: Int
    let image: ImageData
    let username: String
    let squadIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case image
        case username
        case squadIDS = "squad_ids"
    }
}

// MARK: - Image
struct ImageData: Codable, Hashable {
    let url: String
}
