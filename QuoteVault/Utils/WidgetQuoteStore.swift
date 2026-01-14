//
//  WidgetQuoteStore.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import Foundation

struct WidgetQuoteStore {

    static let suite = UserDefaults(suiteName: "group.com.sanan.quotevault")

    static func save(_ quote: Quote) {
        let data = try? JSONEncoder().encode(quote)
        suite?.set(data, forKey: "widget_quote")
    }

    static func load() -> Quote? {
        guard
            let data = suite?.data(forKey: "widget_quote")
        else { return nil }

        return try? JSONDecoder().decode(Quote.self, from: data)
    }
}
