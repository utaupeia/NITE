//
//  niteclubApp.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI
import SwiftData

@main
struct niteclubApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(SessionManager.shared)
        }
        .modelContainer(sharedModelContainer)
    }
}
