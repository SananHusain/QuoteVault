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
    let kind: String = "QuoteVaultWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: QuoteProvider()
        ) { entry in
            QuoteWidgetView(entry: entry)
        }
        .configurationDisplayName("Quote of the Day")
        .description("Daily inspiration from QuoteVault")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
