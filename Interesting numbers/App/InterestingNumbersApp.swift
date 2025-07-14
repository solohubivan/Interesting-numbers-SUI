//
//  InterestingNumbersApp.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 08.07.2025.
//

import SwiftUI
import WidgetKit

@main
struct InterestingNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    WidgetCenter.shared.reloadTimelines(ofKind: "InterestingNumbersWidget")
                }
        }
    }
}
