//
//  LoginView.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - LoginView
struct LoginView: View {
    @StateObject private var loginService = LoginService()
    @State private var userName: String = .empty
    @State private var password: String = .empty
    @FocusState private var focusedField: Textfields?
    var body: some View {
        VStack {
            GrayTextField(text: $userName,
                          title: "Username",
                          hint: "Please enter your username",
                          isFocused: focusedField == .userName)
                .tag(Textfields.userName)
                .onTapGesture {
                    focusedField = .userName
                }
                .focused($focusedField, equals: .userName)
            GrayTextField(text: $password,
                          title: "Password",
                          hint: "Please enter your password",
                          isFocused: focusedField == .password)
                .tag(Textfields.password)
                .onTapGesture {
                    focusedField = .password
                }
                .focused($focusedField, equals: .password)
            
            Button("Login") {
                focusedField = .none
                print("Noam: Here ✋")
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(AppColours.gradient))


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
