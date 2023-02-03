//
//  AppColours.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - AppColours
enum AppColours {
    public static let gradient: LinearGradient = .init(colors: [
        .init(hex: "#4b6cb7"),
        .init(hex: "#182848")
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing)

    public static let errorGradient: LinearGradient = .init(colors: [
        .init(hex: "#EB4E3E"),
        .init(hex: "#FF6F76"),
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing)

    public static let secondary: LinearGradient = .init(colors: [
        .secondary
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing)

    static let tintPurple = Color(hex: "#5354EC")
}
