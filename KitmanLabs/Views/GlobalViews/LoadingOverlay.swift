//
//  LoadingOverlay.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

// MARK: - LoadingOverlay

struct LoadingOverlay: ViewModifier {
    @Binding var isShowing: Bool
    var text: String

    func body(content: Content) -> some View {
        content
            .disabled(isShowing)
            .blur(radius: isShowing ? 3 : 0)
            .overlay {
                ProgressView(text)
                    .frame(width: UIScreen.main.bounds.size.width / 2,
                           height: UIScreen.main.bounds.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(isShowing ? 1 : 0)
                    .scaleEffect(isShowing ? 1 : 0.1)
                    .animation(.easeInOut, value: isShowing)
            }
    }
}

extension View {
    func loadingOverlay(isShowing: Binding<Bool>, text: String) -> some View {
        modifier(LoadingOverlay(isShowing: isShowing, text: text))
    }
}
