//
//  Constants.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation
/// In a real project, this should be added to the .gitIgnore file and should either be ENV variables in the CI
/// or provided to the app in a different way. While these are not secret, we might want to hide them for whatever reason.
struct Constants {
    static let baseURL = "https://kml-tech-test.glitch.me"

    enum Paths: String {
        case login = "/session"
        case squad = "/squads"
        case athletes = "/athletes"
    }
}
