import SwiftUI

struct QuoteCardView: View {

    let quote: Quote

    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var collectionsVM: CollectionsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel

    @State private var showSaveAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("“\(quote.text)”")
                .font(.system(size: settingsVM.fontSize))

            Text("- \(quote.author)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 18) {

                // ❤️ FAVORITE (NO SHEET)
                Button {
                    if let userId = authVM.userId() {
                        Task {
                            await favoritesVM.toggleFavorite(
                                quote: quote,
                                userId: userId
                            )
                        }
                    }
                } label: {
                    Image(systemName: favoritesVM.isFavorite(quote) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }

                // 📁 ADD TO COLLECTION (MENU)
                Menu {
                    ForEach(collectionsVM.collections) { collection in
                        Button(collection.name) {
                            Task {
                                await collectionsVM.addQuote(
                                    quoteId: quote.id,
                                    collectionId: collection.id
                                )
                            }
                        }
                    }
                } label: {
                    Image(systemName: "folder.badge.plus")
                }

                // 📤 SHARE AS IMAGE
                Button {
                    saveQuoteAsImage()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }

                Spacer()
            }
        }
        .padding(.vertical, 6)
        .alert("Saved!", isPresented: $showSaveAlert) {
            Button("OK") {}
        } message: {
            Text("Quote image saved to Photos")
        }
    }
    
    private func saveQuoteAsImage() {
        let image = QuoteImageView(quote: quote).snapshot()

        UIImageWriteToSavedPhotosAlbum(
            image,
            nil,
            nil,
            nil
        )

        showSaveAlert = true
    }

}
