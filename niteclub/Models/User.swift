//
//  User.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI

enum UserStatus: String, Codable {
    case `default`       // regular user with no special privileges
    case member          // member with some special privileges
    case foreverMember   // member with lifetime special privileges
    case admin           // user with administrative privileges
}

struct User: Identifiable, Equatable {
    
    // Define the equality operator for instances of the User type.
    static func == (lhs: User, rhs: User) -> Bool {
        // Check if the 'id' property of the left-hand side user (lhs)
        // is equal to the 'id' property of the right-hand side user (rhs).
        // Return 'true' if they are equal; otherwise, return 'false'.
        return lhs.id == rhs.id
    }
    
    var status: UserStatus  // new property for the User's Status [ default / member / foreverMember / admin ]
    
    var id: UUID
    var username: String
    var profilePicture: String //Image
    var following: [UUID] // IDs of users that this user is following
    var followers: [UUID] // IDs of users that follow this user
    var lurking: Int // count of unique profile visits without following
    var acquiredThemes: [ThemeContent] // themes the user has acquired
    var selectedTheme: ThemeContent // the currently selected theme, if there is one
    var dateJoined: Date
    var location: String  // This could also be a custom 'Location' type if you need more detail
    var likedPosts: [Post] /*= []*/ // Posts that the user has liked.

    // verified
    // birthdate
    // email
    // invited by what user
    // account number
    // routing number
    // date joined
    // location (should be State from ID scan)
    // gender (from ID scan)
    // link
    
    // followsYou
    // isBlocked
    // has notifications ON
    
    
    // Initializer
    init(id: UUID = UUID(), username: String, profilePicture: String, following: [UUID] = [], followers: [UUID] = [], lurking: Int = 0, status: UserStatus = .default, acquiredThemes: [ThemeContent] = [], selectedTheme: ThemeContent, dateJoined: Date, location: String, likedPosts: [Post] = []) {
        self.id = id
        self.username = username
        self.profilePicture = profilePicture
        self.following = following
        self.followers = followers
        self.lurking = lurking
        self.status = status
        self.acquiredThemes = acquiredThemes
        self.selectedTheme = selectedTheme
        self.dateJoined = dateJoined
        self.location = location
        self.likedPosts = likedPosts
    }
    
    
    mutating func follow(user: User) {
        // Add the user's ID to your 'following' list
        following.append(user.id)
        
        // In a real scenario, you would also want to update the other user's 'followers' list, likely through a server-side operation
    }
    
    mutating func unfollow(user: User) {
        // Remove the user's ID from your 'following' list
        following.removeAll { $0 == user.id }
        
        // Similarly, you would update the other user's 'followers' list server-side in a real scenario
    }
    
    mutating func acquireTheme(_ theme: ThemeContent) {
        // Add the theme to the user's collection if it's not already there.
        if !acquiredThemes.contains(where: { $0.id == theme.id }) {
            acquiredThemes.append(theme)
        }
        
        
    }
}


class SessionManager {
    static let shared = SessionManager()  // Singleton instance

    private init() {}  // Prevents direct instantiation

    var currentUser: User?  // Currently logged-in user
}

////let regularUser = User(username: "regularUser", profilePicture: "", role: .default)
//let adminUser = User(username: "adminUser", profilePicture: "", role: .admin)
//
//// Logic check based on roles
//if adminUser.status == .admin {
//    // Perform some admin-only operation or show admin features
//}

