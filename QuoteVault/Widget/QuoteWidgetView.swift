//
//  QuoteWidgetView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//

import SwiftUICore
struct QuoteWidgetView: View {

    let entry: QuoteEntry

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 8) {
                Text("“\(entry.quote)”")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)

                Text("— \(entry.author)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
    }
}
