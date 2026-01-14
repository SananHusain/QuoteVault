//
//  CollectionsViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import Foundation
import Supabase

@MainActor
class CollectionsViewModel: ObservableObject {

    @Published var collections: [QuoteCollection] = []

    private let client = SupabaseService.shared.client

    // MARK: - Load Collections + Quote Count
    func loadCollections(userId: UUID) async {
        do {
            let response = try await client
                .database
                .from("collections")
                .select("""
                    id,
                    name,
                    collection_quotes(count)
                """)
                .eq("user_id", value: userId.uuidString)
                .execute()

            let data = response.data
            let decoded = try JSONDecoder().decode([CollectionWithCount].self, from: data)

            self.collections = decoded.map {
                QuoteCollection(
                    id: $0.id,
                    name: $0.name,
                    quote_count: $0.collection_quotes.first?.count ?? 0
                )
            }

        } catch {
            print("❌ Load collections failed:", error)
        }
    }

    // MARK: - Create Collection
    func createCollection(name: String, userId: UUID) async {
        do {
            try await client
                .database
                .from("collections")
                .insert([
                    "name": name,
                    "user_id": userId.uuidString
                ])
                .execute()

            await loadCollections(userId: userId)

        } catch {
            print("❌ Create collection failed:", error)
        }
    }

    // MARK: - Add Quote to Collection
    func addQuote(quoteId: UUID, collectionId: UUID) async {
        do {
            try await client
                .database
                .from("collection_quotes")
                .insert([
                    "quote_id": quoteId.uuidString,
                    "collection_id": collectionId.uuidString
                ])
                .execute()
        } catch {
            print("❌ Add quote failed:", error)
        }
    }
}

// Helper for decoding
struct CollectionWithCount: Decodable {
    let id: UUID
    let name: String
    let collection_quotes: [CountWrapper]
}

struct CountWrapper: Decodable {
    let count: Int
}
