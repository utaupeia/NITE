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
    var invitedBy: UUID?  // ID of the user who invited them

<<<<<<< HEAD
//
//     closeFriends [] mutual following / follower relationship, electively added to friends list
//     createdThemes / themes user has created
//     isVerified / Bool
//     birthdate
//     email
//     invited by / which user invite code was used to join app if any
//     first name
//     last name
//     account number / only needed for theme creation
//     routing number / only needed for theme creation
//     gender ()
//     websiteURL / added website from user
//     postsCreated
//     commentsMade / all comments made on others posts
//     lastActive / last date active
//     likedSongs / songs user has liked
//     followsYou / user relationship
//     isBlocked / is user blocked by
//     blockedUsers / users that have been blocked
//     has notifications turned on
//    
=======
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
    
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    
    // Initializer
    init(id: UUID = UUID(), username: String, profilePicture: String, following: [UUID] = [], followers: [UUID] = [], lurking: Int = 0, status: UserStatus = .default, acquiredThemes: [Theme] = [], selectedTheme: Theme, dateJoined: Date, location: String, likedPosts: [Post] = [], invitedBy: UUID? = nil) {
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
        self.invitedBy = invitedBy
    }
    
    func isCurrentUser() -> Bool {
        return self.id == SessionManager.shared.currentUserId
    }

    func isCloseFriend(of user: User) -> Bool {
        return closeFriends.contains(user.id)
    }
    
}

class UserDataManager {
    // Sample user data; replace with actual data source in a real app
    static let allUsers = [SampleData.userJohn, SampleData.userEmma, SampleData.userBuhle, SampleData.userRickkw, SampleData.userRobert, SampleData.userYannie]

    static func fetchUser(forCreatorId creatorId: UUID) -> User? {
        return allUsers.first { $0.id == creatorId }
    }
}


//class SessionManager: ObservableObject {
//    static let shared = SessionManager()
//
//    // This property holds the current user's information.
//    // It's optional to account for cases where there is no logged-in user.
//    var currentUser: User? {
//        didSet {
//            // Notify interested parts of your app that the currentUser has changed.
//            // You can use NotificationCenter or a similar mechanism for this.
//            NotificationCenter.default.post(name: .currentUserDidChange, object: currentUser)
//        }
//    }
//
//    // Additional session-related methods can be added here.
//    // For example, methods for logging in, logging out, etc.
//}

class SessionManager: ObservableObject {
    static let shared = SessionManager()

    // Use @Published to notify observers about changes
    @Published var currentUserId: UUID?

    private init() {}

    // Function to log in a user
    func loginUser(withUserId userId: UUID) {
        currentUserId = userId
        // Additional login logic here
        // e.g., storing the user ID in persistent storage
    }

    // Function to log out the current user
    func logoutUser() {
        currentUserId = nil
        // Additional logout logic here
        // e.g., clearing the user ID from persistent storage
    }

    // Function to check if there's a user currently logged in
    func isUserLoggedIn() -> Bool {
        return currentUserId != nil
    }

    // Optionally, if you want to directly access the User object
    // from the SessionManager, you could add a computed property like this:
     var currentUser: User? {
         // For testing or development, return a sample user directly
         // Comment or remove this line in the production code
         return SampleData.userJohn

         // In production, use the following logic:
         // guard let userId = currentUserId else { return nil }
         // return UserDataManager.fetchUser(forCreatorId: userId)
     }
}




//    func logIn(with credentials: Credentials, completion: @escaping (Result<User, Error>) -> Void) {
//        // Implement login logic here, then update currentUser
//    }

//    func logOut() {
//        // Implement logout logic here
//        currentUser = nil
//    }

    // Other session-related methods...

    // Example of a thread-safe way to update currentUser
//    func updateCurrentUser(_ newUser: User?) {
//        DispatchQueue.main.async { [weak self] in
//            self?.currentUser = newUser
//        }
//    }

extension Notification.Name {
    static let currentUserDidChange = Notification.Name("currentUserDidChange")
}

////let regularUser = User(username: "regularUser", profilePicture: "", role: .default)
//let adminUser = User(username: "adminUser", profilePicture: "", role: .admin)
//
//// Logic check based on roles
//if adminUser.status == .admin {
//    // Perform some admin-only operation or show admin features
//}

