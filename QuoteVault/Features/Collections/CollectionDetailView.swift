//
//  CollectionDetailView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//
import SwiftUI
import Supabase

struct CollectionDetailView: View {

    let collection: QuoteCollection
    @State private var quotes: [Quote] = []

    private let client = SupabaseService.shared.client

    var body: some View {
        List {
            ForEach(quotes) { quote in
                HStack {
                    Text(quote.text)
                    Spacer()
                    Button(role: .destructive) {
                        Task {
                            await removeQuote(quote)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .navigationTitle(collection.name)
        .task {
            await loadQuotes()
        }
    }

    private func loadQuotes() async {
        do {
            let response = try await client
                .database
                .from("collection_quotes")
                .select("""
                    quotes (
                        id,
                        text,
                        author,
                        category
                    )
                """)
                .eq("collection_id", value: collection.id.uuidString)
                .execute()

            let decoded = try JSONDecoder()
                .decode([CollectionQuoteWrapper].self, from: response.data)

            quotes = decoded.map { $0.quotes }

        } catch {
            print("❌ Load quotes failed:", error)
        }
    }

    private func removeQuote(_ quote: Quote) async {
        do {
            try await client
                .database
                .from("collection_quotes")
                .delete()
                .eq("collection_id", value: collection.id.uuidString)
                .eq("quote_id", value: quote.id.uuidString)
                .execute()

            quotes.removeAll { $0.id == quote.id }

        } catch {
            print("❌ Remove quote failed:", error)
        }
    }
}

struct CollectionQuoteWrapper: Decodable {
    let quotes: Quote
}
