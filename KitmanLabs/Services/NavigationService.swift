//
//  NavigationService.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

final class NavigationService: ObservableObject {
    @Published var path: [Screen] = []
}

extension NavigationService {
    enum Screen: String {
        case login
        case main
    }
}
