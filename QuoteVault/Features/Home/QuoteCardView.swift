import SwiftUI

struct QuoteCardView: View {

    let quote: Quote

    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var collectionsVM: CollectionsViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel

    
    @ViewBuilder
    private var cardBackground: some View {
        switch settingsVM.quoteCardStyle {

        case .classic:
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 8, y: 4)

        case .gradient:
            LinearGradient(
                colors: [.purple.opacity(0.8), .blue.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(20)

        case .minimal:
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.secondary.opacity(0.4), lineWidth: 1)
                .background(Color.clear)
        }
    }

    @State private var showSaveAlert = false

    private var shareText: String {
        """
        “\(quote.text)”
        — \(quote.author)

        Shared via QuoteVault
        """
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {

            Text("“\(quote.text)”")
                .font(.system(size: settingsVM.fontSize, weight: .medium))
                .foregroundColor(.primary)

            Text("— \(quote.author)")
                .font(.caption)
                .foregroundColor(.secondary)

            Divider()

            HStack(spacing: 20) {

                // ❤️ FAVORITE
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

                // 📁 ADD TO COLLECTION
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

                // 📤 SAVE AS IMAGE
                Menu {
                    Button {
                        saveQuoteAsImage()
                    } label: {
                        Label("Save as Image", systemImage: "photo")
                    }

                    ShareLink(
                        item: shareText,
                        preview: SharePreview("Quote", image: Image(systemName: "text.quote"))
                    ) {
                        Label("Share as Text", systemImage: "text.alignleft")
                    }

                } label: {
                    Image(systemName: "square.and.arrow.up")
                }


                Spacer()
            }
            .font(.title3)
        }
        .padding()
        .background(cardBackground)
        
        .alert("Saved!", isPresented: $showSaveAlert) {
            Button("OK") {}
        } message: {
            Text("Quote image saved to Photos")
        }
    }

    private func saveQuoteAsImage() {
        let image = QuoteImageView(quote: quote).snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        showSaveAlert = true
    }
}


