import WidgetKit
import SwiftUI

// MARK: - Shared Store (App Group)

struct WidgetQuoteStore {

    static let suite = UserDefaults(
        suiteName: "group.com.sananhusain.quotevault"
    )

    static func load() -> (text: String, author: String) {
        let text = suite?.string(forKey: "widget_quote_text")
            ?? "Stay inspired ✨"
        let author = suite?.string(forKey: "widget_quote_author")
            ?? "QuoteVault"
        return (text, author)
    }
}

// MARK: - Timeline Entry

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
    let author: String
}

// MARK: - Provider

struct QuoteProvider: TimelineProvider {

    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "Believe in yourself.",
            author: "QuoteVault"
        )
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (QuoteEntry) -> Void
    ) {
        let data = WidgetQuoteStore.load()
        completion(
            QuoteEntry(
                date: Date(),
                quote: data.text,
                author: data.author
            )
        )
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<QuoteEntry>) -> Void
    ) {
        let data = WidgetQuoteStore.load()

        let entry = QuoteEntry(
            date: Date(),
            quote: data.text,
            author: data.author
        )

        // Update once per day
        let nextUpdate = Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Date()
        )!

        completion(
            Timeline(
                entries: [entry],
                policy: .after(nextUpdate)
            )
        )
    }
}

// MARK: - Widget View

struct QuoteVaultWidgetView: View {

    let entry: QuoteEntry

    var body: some View {
        VStack(spacing: 8) {
            Text("“\(entry.quote)”")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(4)

            Text("— \(entry.author)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.85))
        }
        .padding()
        .widgetBackground()   // ✅ ALWAYS APPLIED
    }
}

extension View {
    @ViewBuilder
    func widgetBackground() -> some View {
        if #available(iOS 17.0, *) {
            self.containerBackground(
                LinearGradient(
                    colors: [.purple, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                for: .widget
            )
        } else {
            self.background(
                LinearGradient(
                    colors: [.purple, .blue],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }
}




// MARK: - Widget Config

//@main
struct QuoteVaultWidget: Widget {

    let kind = "QuoteVaultWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: QuoteProvider()
        ) { entry in
            QuoteVaultWidgetView(entry: entry)
        }
        .configurationDisplayName("Quote of the Day")
        .description("Daily inspiration from QuoteVault")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
