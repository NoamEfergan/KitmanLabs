//
//  LoginViewModel.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - LoginViewModel

final class LoginViewModel: ObservableObject {
    private let networkService = NetworkService()
    @Published var userName: String = .empty
    @Published var password: String = .empty
    @Published var hasUsernameError = false
    @Published var hasPasswordError = false
    @Published var hasGeneralError = false
    @Published var isLoading = false

    @MainActor
    func performLogin() async -> Bool {
        defer {
            isLoading = false
        }
        do {
            guard !userName.isEmpty else {
                hasUsernameError = true
                return false
            }
            guard !password.isEmpty else {
                hasPasswordError = true
                return false
            }
            isLoading = true
            hasPasswordError = false
            hasUsernameError = false
            let response = try await networkService.perform(path: .login,
                                                            responseType: LoginResponse.self,
                                                            requestType: .POST,
                                                            body: [
                                                                "username": userName,
                                                                "password": password,
                                                            ])
            UserDefaults.userName = response.username ?? "User"
            return true
        } catch {
            print("Failed to log in with error: \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: LoginViewModel.LoginError

extension LoginViewModel {
    enum LoginError: Error {
        case invalidUsername
        case invalidPassword
        case noneFound
    }
}
