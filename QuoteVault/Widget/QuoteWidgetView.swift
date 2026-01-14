//
//  QuoteWidgetView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//

import SwiftUICore


struct QuoteWidgetView: View {

    let entry: QuoteProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("“\(entry.quote.text)”")
                .font(.headline)
                .lineLimit(3)

            Text("— \(entry.quote.author)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .widgetURL(
            URL(string: "quotevault://quote?id=\(entry.quote.id.uuidString)")
        )
    }
}
