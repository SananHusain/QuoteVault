//
//  MockData.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import Foundation

struct MockData {
    static let quotes: [Quote] = [
        Quote(id: UUID(), text: "Believe in yourself.", author: "Unknown", category: "Motivation"),
        Quote(id: UUID(), text: "Success is not final.", author: "Winston Churchill", category: "Success"),
        Quote(id: UUID(), text: "Love all, trust a few.", author: "Shakespeare", category: "Love"),
        Quote(id: UUID(), text: "Wisdom begins in wonder.", author: "Socrates", category: "Wisdom"),
        Quote(id: UUID(), text: "Life is short. Smile.", author: "Unknown", category: "Humor")
    ]
}
