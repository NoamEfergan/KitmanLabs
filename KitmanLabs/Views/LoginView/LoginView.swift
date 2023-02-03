//
//  LoginView.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - LoginView

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @FocusState private var focusedField: Textfields?

    var body: some View {
        VStack(spacing: 10) {
            GrayTextField(text: $loginVM.userName,
                          title: "Username",
                          hint: "Please enter your username",
                          isFocused: focusedField == .userName,
                          hasError: loginVM.hasUsernameError,
                          errorText: "Please enter a valid username")
                .tag(Textfields.userName)
                .onTapGesture {
                    focusedField = .userName
                }
                .focused($focusedField, equals: .userName)
            GrayTextField(text: $loginVM.password,
                          title: "Password",
                          hint: "Please enter your password",
                          isSecure: true,
                          isFocused: focusedField == .password,
                          hasError: loginVM.hasPasswordError,
                          errorText: "Please enter a valid password")
                .tag(Textfields.password)
                .onTapGesture {
                    focusedField = .password
                }
                .focused($focusedField, equals: .password)

            Button("Login") {
                focusedField = .none
                Task {
                    await loginVM.performLogin()
                }
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .backgroundStyle(AppColours.gradient)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
        .loadingOverlay(isShowing: $loginVM.isLoading, text: "Logging you in")
        .alert("Whoops!\nsomething went wrong",
               isPresented: $loginVM.hasGeneralError) {
            Button {
                loginVM.hasGeneralError = false
            } label: {
                Text("Please try again later")
            }
        }
        .padding()
        .onAppear {
            focusedField = .userName
        }
    }
}

// MARK: - LoginView_Previews

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

// MARK: - LoginView.Textfields

extension LoginView {
    private enum Textfields: Hashable {
        case userName
        case password
    }
}
