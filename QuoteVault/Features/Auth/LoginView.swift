//
//  LoginView 2.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//


import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false
    @State private var showForgot = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("QuoteVault")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {
                    Task {
                        await authVM.login(email: email, password: password)
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Forgot Password?") {
                    showForgot = true
                }
                .font(.caption)

                Spacer()

                Button("Create Account") {
                    showSignup = true
                }
            }
            .padding()
            .alert("Error", isPresented: .constant(authVM.errorMessage != nil)) {
                Button("OK") {
                    authVM.errorMessage = nil
                }
            } message: {
                Text(authVM.errorMessage ?? "")
            }
            .navigationDestination(isPresented: $showSignup) {
                SignupView()
            }
            .navigationDestination(isPresented: $showForgot) {
                ForgotPasswordView()
            }
        }
    }
}
