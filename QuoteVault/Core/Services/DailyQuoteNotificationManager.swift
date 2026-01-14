//
//  DailyQuoteNotificationManager.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import Foundation
import UserNotifications

struct DailyQuoteNotificationManager {

    static func requestPermission() async {
        try? await UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound])
    }

    static func scheduleDailyQuote(
        quote: String,
        author: String,
        time: Date
    ) async {

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["daily_quote"])

        let content = UNMutableNotificationContent()
        content.title = "Quote of the Day"
        content.body = "“\(quote)” — \(author)"
        content.sound = .default

        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: time
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "daily_quote",
            content: content,
            trigger: trigger
        )

        try? await center.add(request)
    }
}
