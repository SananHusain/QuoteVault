//
//  AuthTextField.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import SwiftUI

struct AuthTextField: View {

    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)

            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}
