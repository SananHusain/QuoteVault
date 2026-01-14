import SwiftUI

struct HomeView: View {

    @StateObject private var quoteVM = QuoteViewModel()
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @EnvironmentObject var collectionsVM: CollectionsViewModel

    var body: some View {
        NavigationStack {
            List {

                if let quote = quoteVM.quoteOfTheDay() {
                    Section("Quote of the Day") {
                        QuoteCardView(quote: quote)
                    }
                }

                Section("All Quotes") {
                    ForEach(quoteVM.filteredQuotes) { quote in
                        QuoteCardView(quote: quote)
                    }
                }
            }
            .navigationTitle("Quotes")
            .searchable(text: $quoteVM.searchText)
            .task {
                await quoteVM.fetchQuotes()

                if let userId = authVM.userId() {
                    await favoritesVM.loadFavorites(userId: userId)
                    
                }
            }
            .task {
                if let userId = authVM.userId() {
                    await collectionsVM.loadCollections(userId: userId)
                }
            }

        }
    }
}
