//
//  QuoteVaultWidget.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//

import SwiftUI
import WidgetKit

@main
struct QuoteVaultWidget: Widget {

    let kind = "QuoteVaultWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: QuoteProvider()
        ) { entry in
            if #available(iOS 17.0, *) {
                QuoteVaultWidgetView(entry: entry)
                    .containerBackground(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        for: .widget
                    )
            } else {
                QuoteVaultWidgetView(entry: entry)
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        }

        .configurationDisplayName("Quote of the Day")
        .description("Daily inspiration from QuoteVault")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
