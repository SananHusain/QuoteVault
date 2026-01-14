//
//  CollectionModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import Foundation

struct CollectionModel: Identifiable {
    let id = UUID()
    let name: String
    var quotes: [Quote]
}
