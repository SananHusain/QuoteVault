//
//  QuoteCollection.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//
import Foundation

struct QuoteCollection: Identifiable, Decodable {
    let id: UUID
    let name: String
    let quote_count: Int?
}


