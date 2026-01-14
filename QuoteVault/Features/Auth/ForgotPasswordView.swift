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
        AuthBackgroundView {
            VStack {
                Spacer()

                VStack(spacing: 20) {

                    Text("Reset Password")
                        .font(.title.bold())
                        .foregroundColor(.white)

                    AuthTextField(
                        icon: "envelope",
                        placeholder: "Enter your email",
                        text: $email
                    )

                    Button {
                        Task {
                            await authVM.resetPassword(email: email)
                            sent = true
                        }
                    } label: {
                        Text("Send Reset Email")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }

                    if sent {
                        Text("Reset email sent. Check your inbox.")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(24)
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}
