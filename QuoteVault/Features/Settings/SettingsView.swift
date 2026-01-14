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
        ScrollView {
            VStack(spacing: 24) {

                // 🌙 APPEARANCE
                settingsCard {
                    Toggle(isOn: $settingsVM.isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }

                // 🔠 FONT SIZE
                settingsCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Font Size", systemImage: "textformat.size")

                        Slider(value: $settingsVM.fontSize, in: 14...28)

                        Text("Size: \(Int(settingsVM.fontSize))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }


                
                // ⏰ DAILY QUOTE TIME
                settingsCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Daily Quote Time", systemImage: "clock")

                        DatePicker(
                            "Time",
                            selection: Binding(
                                get: { settingsVM.notificationTime },
                                set: { settingsVM.notificationTime = $0 }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)

                        Text("You’ll receive a quote every day at this time")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                settingsCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Quote Style", systemImage: "rectangle.on.rectangle")

                        Picker("Style", selection: $settingsVM.quoteCardStyle) {
                            Text("Classic").tag(QuoteCardStyle.classic)
                            Text("Gradient").tag(QuoteCardStyle.gradient)
                            Text("Minimal").tag(QuoteCardStyle.minimal)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                // 🚪 LOGOUT
                settingsCard {
                    Button(role: .destructive) {
                        Task {
                            await authVM.logout()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward.circle")
                            Text("Logout")
                            Spacer()
                        }
                    }
                }



                Spacer()
            }
            .padding()
        }
        .navigationTitle("Settings")
    }

    // MARK: - Reusable Card
    private func settingsCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
        )
    }
}
