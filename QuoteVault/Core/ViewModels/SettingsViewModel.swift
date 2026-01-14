//
//  SettingsViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import SwiftUI

class SettingsViewModel: ObservableObject {

    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("dailyQuoteTime") var dailyQuoteTime: Double = Date().timeIntervalSince1970
    @AppStorage("quoteCardStyle") var quoteCardStyle: QuoteCardStyle = .classic

    var notificationTime: Date {
        get { Date(timeIntervalSince1970: dailyQuoteTime) }
        set { dailyQuoteTime = newValue.timeIntervalSince1970 }
    }
}

