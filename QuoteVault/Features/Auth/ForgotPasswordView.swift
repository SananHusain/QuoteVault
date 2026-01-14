//
//  ForgotPasswordView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 14/01/26.
//


import SwiftUI

struct ForgotPasswordView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var sent = false

    var body: some View {
        VStack(spacing: 20) {

            Text("Reset Password")
                .font(.title)
                .bold()

            TextField("Enter your email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            Button("Send Reset Email") {
                Task {
                    await authVM.resetPassword(email: email)
                    sent = true
                }
            }
            .buttonStyle(.borderedProminent)

            if sent {
                Text("Reset email sent. Check your inbox.")
                    .font(.caption)
                    .foregroundColor(.green)
            }

            Spacer()
        }
        .padding()
    }
}
