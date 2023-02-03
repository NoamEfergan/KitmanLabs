//
//  KitmanLabsApp.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

@main
struct KitmanLabsApp: App {
    @StateObject var navigationService = NavigationService()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(navigationService)
        }
    }
}
