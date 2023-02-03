//
//  MainViewVM.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation

final class MainViewVM: ObservableObject {
    @Published var isLoading: Bool = false
    
    @MainActor
    func getContent() async {
        isLoading = true
        defer {
            isLoading = false
        }
    }
}
