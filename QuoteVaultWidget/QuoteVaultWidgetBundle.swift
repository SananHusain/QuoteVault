//
//  QuoteVaultWidgetBundle.swift
//  QuoteVaultWidget
//
//  Created by Sanan Husain on 14/01/26.
//

import WidgetKit
import SwiftUI

@main
struct QuoteVaultWidgetBundle: WidgetBundle {
    var body: some Widget {
        QuoteVaultWidget()
        QuoteVaultWidgetControl()
        QuoteVaultWidgetLiveActivity()
    }
}
