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

struct User: Identifiable, Equatable, Hashable {
    
    // Define the equality operator for instances of the User type.
    static func == (lhs: User, rhs: User) -> Bool {
        // Check if the 'id' property of the left-hand side user (lhs)
        // is equal to the 'id' property of the right-hand side user (rhs).
        // Return 'true' if they are equal; otherwise, return 'false'.
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use the 'id' property for hashing
    }

    var status: UserStatus  // new property for the User's Status [ default / member / foreverMember / admin ]
    
    var id: UUID
    var username: String
    var profilePicture: String //Image
    var following: [UUID] // IDs of users that this user is following
    var followers: [UUID] // IDs of users that follow this user
    var closeFriends: [UUID] = [] // IDs of users that AuthUser selected to be Close Friends
    var lurking: Int // count of unique profile visits without following
    var acquiredThemes: [Theme] // themes the user has acquired
    var selectedTheme: Theme // the currently selected theme, if there is one
    var dateJoined: Date
    var location: String  // This could also be a custom 'Location' type if you need more detail
    var likedPosts: [Post] /*= []*/ // Posts that the user has liked.

    // closeFriends [] mutual following / follower relationship, electively added to friends list
    // createdThemes / themes user has created
    // isVerified / Bool
    // birthdate
    // email
    // invited by / which user invite code was used to join app if any
    // first name
    // last name
    // account number / only needed for theme creation
    // routing number / only needed for theme creation
    // gender ()
    // websiteURL / added website from user
    // postsCreated
    // commentsMade / all comments made on others posts
    // lastActive / last date active
    // likedSongs / songs user has liked
    // followsYou / user relationship
    // isBlocked / is user blocked by
    // blockedUsers / users that have been blocked
    // has notifications turned on
    
    
    // Initializer
    init(id: UUID = UUID(), username: String, profilePicture: String, following: [UUID] = [], followers: [UUID] = [], lurking: Int = 0, status: UserStatus = .default, acquiredThemes: [Theme] = [], selectedTheme: Theme, dateJoined: Date, location: String, likedPosts: [Post] = []) {
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
    
    mutating func addCloseFriend(user: User) {
        if !closeFriends.contains(user.id) {
            closeFriends.append(user.id)
        }
    }

    mutating func removeCloseFriend(user: User) {
        closeFriends.removeAll { $0 == user.id }
    }

    func isCloseFriend(of user: User) -> Bool {
        return closeFriends.contains(user.id)
    }

    
//    mutating func acquireTheme(_ theme: Theme) {
//        // Check and append based on ThemeContent
//        let themeContent = theme.content
//        if !acquiredThemes.contains(where: { $0.id == theme.id }) {
//            acquiredThemes.append(theme)
//        }
//    }
    
//    mutating func acquireTheme(_ theme: Theme) {
//        // Add the theme to the user's collection if it's not already there.
//        if !acquiredThemes.contains(where: { $0.id == theme.id }) {
//            acquiredThemes.append(theme)
//        }
//    }
}

class UserDataManager {
    // Sample user data; replace with actual data source in a real app
    static let allUsers = [SampleData.userJohn, SampleData.userEmma, SampleData.userBuhle, SampleData.userRickkw, SampleData.userRobert, SampleData.userYannie]

    static func fetchUser(forCreatorId creatorId: UUID) -> User? {
        return allUsers.first { $0.id == creatorId }
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

