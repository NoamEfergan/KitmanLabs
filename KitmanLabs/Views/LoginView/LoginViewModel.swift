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
    func performLogin() async {
        defer {
            isLoading = false
        }
        do {
            guard !userName.isEmpty else {
                hasUsernameError = true
                return
            }
            guard !password.isEmpty else {
                hasPasswordError = true
                return
            }
            isLoading = true
            hasPasswordError = false
            hasUsernameError = false
            let response = try await networkService.perform(path: Constants.Paths.login.rawValue,
                                                            responseType: LoginResponse.self,
                                                            requestType: .POST,
                                                            body: [
                                                                "username": "sampleUsername",
                                                                "password": "samplePassword",
                                                            ])
            UserDefaults.userName = response.username ?? "User"
        } catch {

            print("Failed to log in with error: \(error.localizedDescription)")
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
