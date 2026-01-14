//
//  QuoteVaultApp.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//

import SwiftUI

@main
struct QuoteVaultApp: App {

    @StateObject var authVM = AuthViewModel()
    @StateObject var settingsVM = SettingsViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    @StateObject var collectionsVM = CollectionsViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if authVM.isLoggedIn {
                    MainTabView()
                        .environmentObject(authVM)
                        .environmentObject(settingsVM)
                        .environmentObject(favoritesVM)
                        .environmentObject(collectionsVM)
                        .preferredColorScheme(
                            settingsVM.isDarkMode ? .dark : .light
                        )
                } else {
                    LoginView()
                        .environmentObject(authVM)
                }
            }
            // ✅ ADD IT HERE (ON ROOT VIEW)
            .onOpenURL { url in
                DeepLinkManager.shared.handle(url)
            }
        }
    }
}
