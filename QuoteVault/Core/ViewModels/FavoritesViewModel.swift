//
//  FavoritesViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import Foundation
import Supabase

@MainActor
class FavoritesViewModel: ObservableObject {

    @Published var favorites: [Quote] = []

    private let client = SupabaseService.shared.client

    // MARK: - Helpers

    func isFavorite(_ quote: Quote) -> Bool {
        favorites.contains { $0.id == quote.id }
    }

    // MARK: - Toggle Favorite (LOCAL + SUPABASE)

    func toggleFavorite(quote: Quote, userId: UUID) async {
        if isFavorite(quote) {
            await removeFavorite(quote: quote, userId: userId)
        } else {
            await addFavorite(quote: quote, userId: userId)
        }
    }

    // MARK: - Insert

    private func addFavorite(quote: Quote, userId: UUID) async {
        do {
            try await client
                .database
                .from("favorites")
                .insert([
                    "user_id": userId.uuidString,
                    "quote_id": quote.id.uuidString
                ])
                .execute()

            favorites.append(quote) // update UI

        } catch {
            print("❌ Failed to add favorite:", error)
        }
    }

    // MARK: - Delete

    private func removeFavorite(quote: Quote, userId: UUID) async {
        do {
            try await client
                .database
                .from("favorites")
                .delete()
                .eq("user_id", value: userId.uuidString)
                .eq("quote_id", value: quote.id.uuidString)
                .execute()

            favorites.removeAll { $0.id == quote.id } // update UI

        } catch {
            print("❌ Failed to remove favorite:", error)
        }
    }

    // MARK: - Load from Supabase

    func loadFavorites(userId: UUID) async {
        do {
            let response = try await client
                .database
                .from("favorites")
                .select("""
                    quotes (
                        id,
                        text,
                        author,
                        category
                    )
                """)
                .eq("user_id", value: userId.uuidString)
                .execute()

            let decoded = try JSONDecoder()
                .decode([FavoriteQuoteWrapper].self, from: response.data)

            self.favorites = decoded.map { $0.quotes }

        } catch {
            print("❌ Failed to load favorites:", error)
        }
    }
}

// Helper
struct FavoriteQuoteWrapper: Decodable {
    let quotes: Quote
}
