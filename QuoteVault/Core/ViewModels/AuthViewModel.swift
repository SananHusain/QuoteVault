//
//  AuthViewModel.swift
//  QuoteVault
//
//  Created by Sanan Husain on 13/01/26.
//
import Foundation
import Supabase

@MainActor
class AuthViewModel: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    private let client = SupabaseService.shared.client

    // MARK: - Init (Session persistence)
    init() {
        Task {
            if let _ = try? await client.auth.session {
                isLoggedIn = true
            }
        }
    }

    // MARK: - Login
    func login(email: String, password: String) async {
        do {
            try await client.auth.signIn(
                email: email,
                password: password
            )
            isLoggedIn = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Signup
    func signup(email: String, password: String) async {
        do {
            try await client.auth.signUp(
                email: email,
                password: password,
                redirectTo: URL(string: "quotevault://auth-callback")
            )

            errorMessage = "Confirmation email sent. Please verify before logging in."

        } catch {
            errorMessage = error.localizedDescription
        }
    }


    // MARK: - Forgot Password
    func resetPassword(email: String) async {
        do {
            try await client.auth.resetPasswordForEmail(email)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Logout
    func logout() async {
        try? await client.auth.signOut()
        isLoggedIn = false
    }

    func userId() -> UUID? {
        client.auth.currentUser?.id
    }
}
