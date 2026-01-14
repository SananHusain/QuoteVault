import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false
    @State private var showForgot = false

    var body: some View {
        NavigationStack {
            AuthBackgroundView {
                VStack {
                    Spacer()

                    VStack(spacing: 24) {

                        VStack(spacing: 8) {
                            Text("QuoteVault")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)

                            Text("Discover • Save • Inspire")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.subheadline)
                        }

                        VStack(spacing: 16) {
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
                        }

                        Button {
                            Task {
                                await authVM.login(email: email, password: password)
                            }
                        } label: {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }

                        Button("Forgot Password?") {
                            showForgot = true
                        }
                        .font(.caption)
                        .foregroundColor(.gray)

                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(24)
                    .padding(.horizontal)

                    Spacer()

                    Button {
                        showSignup = true
                    } label: {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.bottom, 30)
                }
            }
            .alert("Error", isPresented: .constant(authVM.errorMessage != nil)) {
                Button("OK") { authVM.errorMessage = nil }
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
