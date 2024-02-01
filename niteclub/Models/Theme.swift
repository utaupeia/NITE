//
//  Theme.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

// The actual content of a theme, which might be an image, video, or other multimedia.
struct ThemeContent: Identifiable {
    var id: UUID

    // Depending on your implementation, this might include URLs to media files,
    // binary data, or references to assets within your system.
    // For simplicity, we're using a string, likely a URL.
    var themeURL: String
}

// A structure representing a theme that users can purchase and use.
struct Theme: Identifiable, Equatable {
    var id: UUID
    var name: String?
    var content: ThemeContent  // Assuming 'Theme' is another struct you've defined
    var price: Double
    var creationDate: Date
    var creator: UUID?  // The ID of the author
    var purchasers: [UUID]  // IDs of users who have purchased the theme
    var approved: Bool

    // Initializer
    init(id: UUID = UUID(), name: String?, content: ThemeContent, price: Double, creationDate: Date, creator: UUID? = nil, approved: Bool = false) {
        self.id = id
        self.name = name
        self.content = content
        self.price = price
        self.creationDate = creationDate
        self.creator = creator
        self.purchasers = []
        self.approved = approved
    }

    // ... other methods ...
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id  // This comparison might be expanded based on what you consider makes two ThemeContents equal.
    }


    // Function to handle the purchase of a theme, adding a user to the purchasers array.
    mutating func purchase(by user: User) {
        // Instead of appending the user, we append the user's ID.
        // This assumes the purchase process is successful and verification is done elsewhere.
        purchasers.append(user.id)
    }

    mutating func submitForReview(by user: User) {
        // We're setting the authorId, not the author object.
        self.creator = user.id
        self.approved = false  // It's not approved until reviewed.
    }

    mutating func approve() {
        // The theme has been reviewed and is now approved.
        self.approved = true
    }


    // ... other methods, such as for refunding, reviewing, featuring themes, etc. ...
}

// Creating a theme. This might be a theme available for purchase in your app.
let themeContent = Theme(
    name: "Cool Blue",
    content: ThemeContent(id: UUID(), themeURL: "url_to_theme_content"),
    price: 2.99,
    creationDate: Date(),  // Assuming the theme is created now
    approved: true  // Let's say this theme is already approved
)

// Creating a user. This user might be someone using your app.
var user = User(
    id: UUID(),
    username: "sampleUser",
    profilePicture: "image4", // This URL is just a placeholder
    following: [], // This user is not following anyone in this example
    followers: [], // This user has no followers in this example
    lurking: 5, // This number is arbitrary
    status: .default, // Using the 'default' status for this example
    acquiredThemes: [sampleTheme], // Assigning the sample theme we created
    selectedTheme: sampleTheme, // This user has selected the sample theme
    dateJoined: Date(), // The date of creating this sample, i.e., now
    location: "USA"
)
//
//// Now, we simulate the user acquiring a new theme. This could be through a purchase process in your app.
//user.acquireTheme(themeContent)
//
//// If the user decides to apply this new theme, you would set it as the selected theme.
//user.selectTheme(themeContent)

extension Theme {
    static let defaultTheme = Theme(
        name: "Default",
        content: ThemeContent(id: UUID(), themeURL: "defaultThemeURL"),
        price: 0.0,
        creationDate: Date(),
        approved: true
    )
}
