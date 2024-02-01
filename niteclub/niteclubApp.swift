//
//  niteclubApp.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI
import SwiftData
// Import any other necessary modules

@main
struct niteclubApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self, // Add other models as needed
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
            AppTabBarView()
                // You can pass environment objects here if needed
                .environmentObject(SessionManager.shared) // Uncomment if you need to use SessionManager
                // Add other environment objects as required
        }
        .modelContainer(sharedModelContainer) // Make sure this is correctly configured
    }
}
