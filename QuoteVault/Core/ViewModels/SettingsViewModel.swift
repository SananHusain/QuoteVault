//
//  SettingsViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("darkMode") var isDarkMode = false
    @AppStorage("fontSize") var fontSize: Double = 18
}
