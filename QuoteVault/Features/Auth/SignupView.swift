//
//  SignupView.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import SwiftUI

struct SignupView: View {

    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        AuthBackgroundView {
            VStack {
                Spacer()

                VStack(spacing: 20) {

                    Text("Create Account")
                        .font(.title.bold())
                        .foregroundColor(.white)

                    AuthTextField(
                        icon: "envelope",
                        placeholder: "Email",
                        text: $email
                    )

                    AuthTextField(
                        icon: "lock",
                        placeholder: "Password",
                        text: $password,
                        isSecure: true
                    )

                    AuthTextField(
                        icon: "lock.fill",
                        placeholder: "Confirm Password",
                        text: $confirmPassword,
                        isSecure: true
                    )

                    Button {
                        guard password == confirmPassword else {
                            authVM.errorMessage = "Passwords do not match"
                            return
                        }

                        Task {
                            await authVM.signup(email: email, password: password)
                        }
                    } label: {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(14)
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
