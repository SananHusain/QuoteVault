//
//  View + Extension.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//

import Foundation

import SwiftUI

extension View {

    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view!

        let size = CGSize(width: 300, height: 300)
        view.bounds = CGRect(origin: .zero, size: size)
        view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}
