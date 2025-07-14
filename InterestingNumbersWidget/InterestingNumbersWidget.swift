//
//  InterestingNumbersWidget.swift
//  InterestingNumbersWidget
//
//  Created by Ivan Solohub on 14.07.2025.
//

import WidgetKit
import SwiftUI
import NumbersCore

// MARK: - Widget Declaration
@main
struct InterestingNumbersWidget: Widget {
    let kind: String = "InterestingNumbersWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NumbersProvider()) { entry in
            NumbersWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Number Fact Widget")
        .description("Displays a random or saved number fact.")
        .supportedFamilies([.systemMedium])
    }
}

// MARK: - Timeline Provider
struct NumbersProvider: TimelineProvider {
    func placeholder(in context: Context) -> NumbersEntry {
        NumbersEntry(date: Date(), number: "42", fact: "42 is the number of US gallons in a barrel of oil.")
    }

    func getSnapshot(in context: Context, completion: @escaping (NumbersEntry) -> ()) {
        let entry = NumbersEntry(date: Date(), number: "42", fact: "42 is the number of US gallons in a barrel of oil.")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<NumbersEntry>) -> Void) {
        let apiBuilder = APIBuilder()
        let apiManager = NumbersApiDataManager()
        let urlString = apiBuilder.createLinkForRequest(type: .trivia(requestedNumber: "random"))
        
        apiManager.fetchFact(for: urlString) { result in
            let fallbackEntry = NumbersEntry(date: Date(), number: "?", fact: "Could not load fact.")
            
            switch result {
            case .success(let fact):
                let number = fact.split(separator: " ").first.map(String.init) ?? "?"
                let entry = NumbersEntry(date: Date(), number: number, fact: fact)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(300)))
                completion(timeline)
            case .failure:
                let timeline = Timeline(entries: [fallbackEntry], policy: .after(Date().addingTimeInterval(300)))
                completion(timeline)
            }
        }
    }
}

// MARK: - Widget View
struct NumbersWidgetEntryView: View {
    var entry: NumbersProvider.Entry

    var body: some View {
        VStack(spacing: 8) {
            Text(entry.number)
                .font(.custom("OpenSans-Bold", size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Text(entry.fact)
                .font(.custom("OpenSans-Medium", size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(Color(hex: "#8033CC"), for: .widget)
    }
}

// MARK: - Preview
#Preview(as: .systemMedium) {
    InterestingNumbersWidget()
} timeline: {
    NumbersEntry(date: Date(), number: "99", fact: "99 is the last two-digit number.")
}
