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
            List {
                if favVM.favorites.isEmpty {
                    Text("No favorites yet ❤️")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(favVM.favorites) { quote in
                        Text(quote.text)
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

