//
//  QuoteVaultApp.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//

//import SwiftUI
//
//@main
//struct QuoteVaultApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
import SwiftUI

@main
struct QuoteVaultApp: App {

    @StateObject var authVM = AuthViewModel()
    @StateObject var settingsVM = SettingsViewModel()
    @StateObject var favoritesVM = FavoritesViewModel()
    @StateObject var collectionsVM = CollectionsViewModel()

    var body: some Scene {
        WindowGroup {
            if authVM.isLoggedIn {
                MainTabView()
                    .environmentObject(authVM)
                    .environmentObject(settingsVM)
                    .environmentObject(favoritesVM)
                    .environmentObject(collectionsVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
