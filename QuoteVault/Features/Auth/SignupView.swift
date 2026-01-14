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
        VStack(spacing: 20) {

            Text("Create Account")
                .font(.title)
                .bold()

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)

            Button("Sign Up") {
                guard password == confirmPassword else {
                    authVM.errorMessage = "Passwords do not match"
                    return
                }

                Task {
                    await authVM.signup(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}
