//
//  SettingsView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsVM: SettingsViewModel
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $settingsVM.isDarkMode)

            VStack {
                Text("Font Size")
                Slider(value: $settingsVM.fontSize, in: 14...28)
            }

            Button("Logout", role: .destructive) {
                Task{
                   await authVM.logout()
                }
            }
        }
        .navigationTitle("Settings")
    }
}
