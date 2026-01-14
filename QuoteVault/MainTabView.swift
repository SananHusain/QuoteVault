//
//  MainTabView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }

            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "heart") }

            CollectionsView()
                .tabItem { Label("Collections", systemImage: "folder") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
