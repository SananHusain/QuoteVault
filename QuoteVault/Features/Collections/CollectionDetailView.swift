//
//  CollectionDetailView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//
import SwiftUI
import Supabase

// MARK: - Supabase Join Wrapper
struct CollectionQuoteWrapper: Decodable {
    let quotes: Quote
}


struct CollectionDetailView: View {

    let collection: QuoteCollection
    @State private var quotes: [Quote] = []

    private let client = SupabaseService.shared.client

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                if quotes.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "text.quote")
                            .font(.system(size: 40))
                            .foregroundColor(.secondary)

                        Text("No quotes in this collection")
                            .font(.headline)

                        Text("Add quotes using the folder icon")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 80)
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(quotes) { quote in
                            QuoteCardView(quote: quote)
                                .overlay(
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Button(role: .destructive) {
                                                Task {
                                                    await removeQuote(quote)
                                                }
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                            .padding(10)
                                            Spacer()
                                        }
                                    }
                                )
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
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
