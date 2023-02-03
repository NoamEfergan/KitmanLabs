//
//  LoginService.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - LoginService
final class LoginService: ObservableObject {
    @Published var isLoading = false

    func logIn(with username: String, and password: String) async throws {
        /// Checking the user name and password are valid. according to the real life usage, we might need to validate
        /// that these are a valid email or that the password fits our criteria with Regex, for example
        guard !username.isEmpty else {
            throw LoginError.invalidUsername
        }
        guard !password.isEmpty else {
            throw LoginError.invalidPassword
        }
    }
}

// MARK: LoginService.LoginError
extension LoginService {
    enum LoginError: Error {
        case invalidUsername
        case invalidPassword
        case noneFound
    }
}
