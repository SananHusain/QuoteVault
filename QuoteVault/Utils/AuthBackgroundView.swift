//
//  AuthBackgroundView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import SwiftUI

struct AuthBackgroundView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            content
        }
    }
}
