//
//  QuoteEntry.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//

import WidgetKit
import SwiftUI

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
    let author: String
}

struct QuoteProvider: TimelineProvider {

    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "Believe in yourself.",
            author: "QuoteVault"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> Void) {
        let data = WidgetQuoteStore.load()
        completion(
            QuoteEntry(
                date: Date(),
                quote: data.text,
                author: data.author
            )
        )
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> Void) {
        let data = WidgetQuoteStore.load()

        let entry = QuoteEntry(
            date: Date(),
            quote: data.text,
            author: data.author
        )

        // Update after 24 hours
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!

        completion(
            Timeline(
                entries: [entry],
                policy: .after(nextUpdate)
            )
        )
    }
}
