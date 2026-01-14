//
//  DeepLinkManager.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import Foundation
import SwiftUI

class DeepLinkManager: ObservableObject {

    static let shared = DeepLinkManager()

    @Published var selectedQuoteID: UUID?

    func handle(_ url: URL) {
        guard
            url.scheme == "quotevault",
            url.host == "quote",
            let idString = URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first(where: { $0.name == "id" })?
                .value,
            let uuid = UUID(uuidString: idString)
        else { return }

        selectedQuoteID = uuid
    }
}
