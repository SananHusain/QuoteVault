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
    let quote: Quote
}

struct QuoteProvider: TimelineProvider {

    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: Quote(
                id: UUID(),
                text: "Stay hungry, stay foolish.",
                author: "Steve Jobs",
                category: "Motivation"
            )
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> Void) {
        let quote = WidgetQuoteStore.load() ?? placeholder(in: context).quote
        completion(QuoteEntry(date: Date(), quote: quote))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> Void) {
        let quote = WidgetQuoteStore.load() ?? placeholder(in: context).quote

        let nextUpdate = Calendar.current.startOfDay(
            for: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        )

        let entry = QuoteEntry(date: Date(), quote: quote)

        completion(
            Timeline(entries: [entry], policy: .after(nextUpdate))
        )
    }
}
