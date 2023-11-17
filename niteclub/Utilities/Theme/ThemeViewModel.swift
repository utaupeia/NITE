//
//  ThemeViewModel.swift
//  niteclub
//
//  Created by +++ on 11/24/23.
//

import Foundation

class ThemeViewModel: ObservableObject {
    @Published var themes: [Theme] = []
    @Published var selectedTheme: Theme
    
    init(selectedTheme: Theme) {
        self.selectedTheme = selectedTheme
        loadThemes()
    }
    // User who creates theme automatically gets their own theme for free 
    func createTheme(name: String, url: String, creatorId: UUID) {
        let newTheme = Theme(
            id: UUID(),
            name: name,
            content: ThemeContent(id: UUID(), themeURL: url),
            price: 0.99, // example price
            creationDate: Date(),
            creator: creatorId,
            approved: true
        )

        if var creator = SampleData.user(for: creatorId) {
            creator.acquiredThemes.append(newTheme)
            // Update the user in your user management system
        }

        // Add the new theme to your theme management system
    }


    // Add methods to handle theme-related operations
    // Example method to load themes (in a real app, this might fetch from a server)
    func loadThemes() {
        // Dummy data for demonstration
        themes = [
            Theme(id: UUID(), name: "sumnsumn", content: ThemeContent(id: UUID(), themeURL: "image33"), price: 0.99, creationDate: Date(), creator: UUID(), approved: true),
            Theme(id: UUID(), name: "cool theme", content: ThemeContent(id: UUID(), themeURL: "image41"), price: 0.99, creationDate: Date(), creator: UUID(), approved: true)
            // Add more themes as needed
        ]
    }


    func purchaseTheme(_ theme: Theme, by user: User) {
        // Handle the purchase logic
        // Update the theme's purchasers list
        // Handle payment processing
    }

    func submitThemeForReview(_ theme: Theme, by user: User) {
        // Submit a theme for review
    }

    func selectTheme(_ theme: Theme) {
        selectedTheme = theme
        // Additional logic when a theme is selected
    }

    // ... other methods ...
}
