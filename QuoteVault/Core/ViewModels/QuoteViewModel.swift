//
//  QuoteViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//

import Foundation
import Supabase

@MainActor
class QuoteViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    @Published var searchText: String = ""
    @Published var isLoading = false


    private let client = SupabaseService.shared.client

    var filteredQuotes: [Quote] {
        if searchText.isEmpty {
            return quotes
        }

        return quotes.filter {
            $0.text.localizedCaseInsensitiveContains(searchText) ||
            $0.author.localizedCaseInsensitiveContains(searchText)
        }
    }

    func fetchQuotes() async {
        isLoading = true
        defer { isLoading = false }
        do {
            quotes = try await client
                .database
                .from("quotes")
                .select()
                .execute()
                .value
        } catch {
            print("❌ Error fetching quotes:", error)
        }
        
        if let quote = quoteOfTheDay() {
            WidgetQuoteStore.save(quote)
        }

    }

    func quoteOfTheDay() -> Quote? {
        guard !quotes.isEmpty else { return nil }
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        return quotes[day % quotes.count]
    }
    
    func scrollToQuote(_ id: UUID) {
        // Optional: store ID and scroll using ScrollViewReader
    }
}
