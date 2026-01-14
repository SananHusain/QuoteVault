//
//  QuoteImageView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import SwiftUI

struct QuoteImageView: View {

    let quote: Quote

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 16) {
                Text("“\(quote.text)”")
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Text("- \(quote.author)")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.headline)
            }
            .padding(32)
        }
        .frame(width: 300, height: 300)
        .cornerRadius(24)
    }
}
