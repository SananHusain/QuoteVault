import SwiftUI

struct HomeView: View {

    @StateObject private var quoteVM = QuoteViewModel()
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @EnvironmentObject private var collectionsVM: CollectionsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    @StateObject private var deepLinkManager = DeepLinkManager.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if quoteVM.isLoading {
                        ProgressView()
                            .padding(.top, 40)
                    }
                    // 🌟 QUOTE OF THE DAY
                    if let quote = quoteVM.quoteOfTheDay() {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Quote of the Day")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            QuoteCardView(quote: quote)
                                .background(
                                    LinearGradient(
                                        colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .cornerRadius(20)
                                )
                        }
                        .padding(.horizontal)
                    }

                    // 📜 ALL QUOTES
                    VStack(alignment: .leading, spacing: 12) {
                        Text("All Quotes")
                            .font(.headline)
                            .padding(.horizontal)

                        LazyVStack(spacing: 16) {
                            ForEach(quoteVM.filteredQuotes) { quote in
                                QuoteCardView(quote: quote)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Quotes")
            .searchable(text: $quoteVM.searchText)
            .task {
                await quoteVM.fetchQuotes()

                if let userId = authVM.userId() {
                    await favoritesVM.loadFavorites(userId: userId)
                    await collectionsVM.loadCollections(userId: userId)
                }
            }
            .task {
                await quoteVM.fetchQuotes()

                if let quote = quoteVM.quoteOfTheDay() {
                    await DailyQuoteNotificationManager.requestPermission()
                    await DailyQuoteNotificationManager.scheduleDailyQuote(
                        quote: quote.text,
                        author: quote.author,
                        time: settingsVM.notificationTime
                    )
                }

                if let userId = authVM.userId() {
                    await favoritesVM.loadFavorites(userId: userId)
                    await collectionsVM.loadCollections(userId: userId)
                }
            }
            .refreshable {
                await quoteVM.fetchQuotes()
            }
            .onChange(of: deepLinkManager.selectedQuoteID) { id in
                guard let id else { return }
                quoteVM.scrollToQuote(id)
            }


        }
    }
    


}
