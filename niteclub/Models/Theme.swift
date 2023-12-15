//
//  Theme.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

// The actual content of a theme, which might be an image, video, or other multimedia.
struct Theme: Codable {
    // Depending on your implementation, this might include URLs to media files,
    // binary data, or references to assets within your system.
    // For simplicity, we're using a string, likely a URL.
    var themeURL: String
}

// A structure representing a theme that users can purchase and use.
struct ThemeContent: Identifiable, Equatable, Codable {
    var id: UUID
    var name: String?
    var content: Theme  // Assuming 'Theme' is another struct you've defined
    var price: Double
    var creationDate: Date
    var authorId: UUID?  // The ID of the author
    var purchasers: [UUID]  // IDs of users who have purchased the theme
    var approved: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, content, price, creationDate, authorId, purchasers, approved
    }

    // Initializer
    init(id: UUID = UUID(), name: String?, content: Theme, price: Double, creationDate: Date, authorId: UUID? = nil, approved: Bool = false) {
        self.id = id
        self.name = name
        self.content = content
        self.price = price
        self.creationDate = creationDate
        self.authorId = authorId
        self.purchasers = []
        self.approved = approved
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        content = try container.decode(Theme.self, forKey: .content)
        price = try container.decode(Double.self, forKey: .price)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        authorId = try container.decodeIfPresent(UUID.self, forKey: .authorId)
        purchasers = try container.decode([UUID].self, forKey: .purchasers)
        approved = try container.decode(Bool.self, forKey: .approved)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }

    // ... other methods ...
    
    static func == (lhs: ThemeContent, rhs: ThemeContent) -> Bool {
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
        self.authorId = user.id
        self.approved = false  // It's not approved until reviewed.
    }

    mutating func approve() {
        // The theme has been reviewed and is now approved.
        self.approved = true
    }


    // ... other methods, such as for refunding, reviewing, featuring themes, etc. ...
}

// Creating a theme. This might be a theme available for purchase in your app.
let themeContent = ThemeContent(
    name: "Cool Blue",
    content: Theme(themeURL: "url_to_theme_content"),
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
