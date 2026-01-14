//
//  FavoritesView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject private var favVM: FavoritesViewModel
    @EnvironmentObject private var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    if favVM.favorites.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "heart")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)

                            Text("No favorites yet")
                                .font(.headline)

                            Text("Tap ❤️ on a quote to save it here")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 80)
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(favVM.favorites) { quote in
                                QuoteCardView(quote: quote)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Favorites")
            .task {
                if let userId = authVM.userId() {
                    await favVM.loadFavorites(userId: userId)
                }
            }
        }
    }
}
