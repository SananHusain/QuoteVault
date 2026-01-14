//
//  SupabaseService.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import Supabase
import Foundation

final class SupabaseService {
    static let shared = SupabaseService()

    let client: SupabaseClient

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://aksbylezgdharztrmxes.supabase.co")!,
            supabaseKey: "sb_publishable_Lo4VpRbijdJKh1kJAoSymQ_2vsXoysQ"
        )
    }
}
