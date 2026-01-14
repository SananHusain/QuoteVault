//
//  Quote.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


// Core/Models/Quote.swift

import Foundation

struct Quote: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let author: String
    let category: String
}
