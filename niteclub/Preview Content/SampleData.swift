//
//  SampleData.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

struct SampleData {
    // Users
    static let userJohn = User(id: UUID(), username: "JohnDoe", profilePicture: "image1", following: [], followers: [], lurking: 7832, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    static let userEmma = User(id: UUID(), username: "EmmaA", profilePicture: "image10", following: [], followers: [], lurking: 322, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    static let userRobert = User(id: UUID(), username: "RobertZ", profilePicture: "image9", following: [], followers: [], lurking: 4257, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
    // ... as many users as you want for variety.
}

// Continuing in SampleData.swift

extension SampleData {
    // Posts by John
    static let johnTextPost = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "John's amazing text post!", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    static let johnImagePost = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "where is this caption", images: ["image6"], videos: nil, socialInteractions: SocialInteractionsManager())
    static let johnImagePost2 = Post(id: UUID(), author: userJohn, timestamp: Date(), textContent: "testing the three image look", images: ["image6", "image5", "image1"], videos: nil, socialInteractions: SocialInteractionsManager())

    // ...

    // Posts by Emma
    static let emmaVideoPost = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "Emma's vacation!", images: nil, videos: ["image7"], socialInteractions: SocialInteractionsManager())
    static let emmaImagePost = Post(id: UUID(), author: userEmma, timestamp: Date(), textContent: "look at my pics!", images: ["image7", "image3"], videos: nil, socialInteractions: SocialInteractionsManager())

    // ...

    // Posts by Robert
    static let robertTextPost = Post(id: UUID(), author: userRobert, timestamp: Date(), textContent: "Robert's thoughts on SwiftUI", images: nil, videos: nil, socialInteractions: SocialInteractionsManager())
    
    static let robertImagePost = Post(id: UUID(), author: userRobert, timestamp: Date(), textContent: "ummm image", images: ["image9", "image8", "image6", "image2"], videos: nil, socialInteractions: SocialInteractionsManager())

    // ...

    // Gather them for easy access and use
    static let allPosts: [Post] = [johnTextPost, johnImagePost, emmaVideoPost, robertTextPost, emmaImagePost, robertImagePost, johnImagePost2] // Add all the posts here
}
