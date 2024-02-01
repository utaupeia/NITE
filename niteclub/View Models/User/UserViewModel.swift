//
//  UserViewModel.swift
//  niteclub
//
//  Created by +++ on 10/27/23.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
<<<<<<< HEAD
    @Published var user: User?
    @Published var userIsFollowed: Bool = false
    @Published var userIsCloseFriend: Bool = false

    @Published var allUsers: [User] = UserDataManager.allUsers
    @Published var pastSearchedUsers = [User]()
=======
    @Published var user: User
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

    @Published var isLoading: Bool = false
    @Published var error: String?
    
    // Properties extracted from 'User' for the view
    var username: String { user?.username ?? "Unknown" }
    var profilePicture: String { user?.profilePicture ?? "DefaultImage" }
    var followerCount: Int { user?.followers.count ?? 0 }
    var followingCount: Int { user?.following.count ?? 0 }
    var lurkingCount: Int { user?.lurking ?? 0 }
    var location: String { user?.location ?? "Unknown Location" }
    // For 'invitedBy' and 'link', I'm providing placeholders as it's unclear how these would be derived from the User model.
    var invitedBy: String { "otheruser" }  // Modify to username of user
    var link: String { "www.website" }  // Optional entry from members
    var selectedTheme: Theme { user?.selectedTheme ?? sampleTheme } // Replace `defaultTheme` with default value
    var navigateToProfile: ((UUID) -> Void)?


    init(user: User? = SessionManager.shared.currentUser) {
        self.user = user
    }
    
    // Function to update the current user
    func setCurrentUser(_ newUser: User) {
        self.user = newUser
        print("UserViewModel initialized with user: \(String(describing: user))")
    }

    // Function to fetch user data
    func setUserByID(_ id: UUID) {
        self.user = SampleData.user(for: id)
//        print("User set in UserViewModel: \(String(describing: user))")

    }

    func fetchUserData() {
        isLoading = true
        // Simulating data fetch with a delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            DispatchQueue.main.async { [weak self] in
                // Safely unwrap self and update user's username
                if let strongSelf = self {
                    strongSelf.user?.username += " Updated"
                    strongSelf.isLoading = false
                }
            }
        }
    }
    
    func toggleUserProfile(to newUser: User) {
        self.user = newUser
    }

    func updateUser(_ newUser: User) {
        user = newUser
    }


    // MARK: CREATING USER
    func someFunctionCreatingUser() {
        // Example data
        let id = UUID()
        let username = "exampleUser"
        let profilePicture = "profilePicURL"
        _ = Theme.defaultTheme
        let dateJoined = Date()
        let location = "exampleLocation"

        // Create a new user
        _ = User(id: id, username: username, profilePicture: profilePicture, selectedTheme: Theme.defaultTheme, dateJoined: dateJoined, location: location )
    }

    // MARK: fetch user data
    
    func performNavigation() {
        if let userID = user?.id {
            navigateToProfile?(userID)
        }
    }
    
    // MARK: SEARCH FUNCTIONS
    
    func addSearchedUsers(_ users: [User]) {
        pastSearchedUsers = Array((users + pastSearchedUsers).prefix(10))
    }

    func removeSearchedUser(_ user: User) {
        pastSearchedUsers.removeAll { $0.id == user.id }
    }
    
    func addUserToPastSearches(_ newUser: User) {
        if !pastSearchedUsers.contains(where: { $0.id == newUser.id }) {
            pastSearchedUsers.insert(newUser, at: 0)
            if pastSearchedUsers.count > 10 {
                pastSearchedUsers.removeLast()
            }
        }
    }

    var randomUsers: [User] {
        return Array(allUsers.shuffled().prefix(6))
    }

    // for search of users / /add priority of members / mutuals / trending or popular
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return allUsers.filter { user in
            user.username.lowercased().contains(lowercasedQuery)
        }
    }

    
    func checkIfUserIsFollowed(otherUser: User) {
        userIsFollowed = user?.following.contains(otherUser.id) ?? false
    }

    // Check if the current user is followed by another user
    func checkIfUserFollowsYou(otherUser: User) -> Bool {
        return otherUser.following.contains(user?.id ?? UUID())
    }
    
    // Check for mutual followers between the current user and another user
    func checkForMutualFollowers(with otherUser: User) -> [UUID] {
        let currentUserFollowers = user?.followers ?? []
        let otherUserFollowers = otherUser.followers

        // Finding the intersection of both sets of followers
        let mutualFollowers = currentUserFollowers.filter { otherUserFollowers.contains($0) }
        return mutualFollowers
    }
    
    func checkIfUserIsCloseFriend(otherUser: User) {
        // Update userIsCloseFriend based on the result
        // For example:
        userIsCloseFriend = user?.closeFriends.contains(otherUser.id) ?? false
    }
    
    func areYouCloseFriend(otherUser: User) -> Bool {
        guard let currentUserID = user?.id else { return false }
        return otherUser.closeFriends.contains(currentUserID)
    }

    // Check if the current user is following the specified user


    // Check if the specified user is followed by the current user
    func isFollowedBy(user otherUser: User) -> Bool {
        guard let currentUser = self.user else { return false }
        return otherUser.followers.contains(currentUser.id)
    }

    func toggleUserProfile(to newUser: User) {
        self.user = newUser
    }

    // MARK: USER EDIT ACTIONS
    func updateUser(_ newUser: User) {
        user = newUser
    }
    
    func changeTheme(to newTheme: Theme) {
        // Directly update the 'selectedTheme' property of the 'user'
        user?.selectedTheme = newTheme
        // Update the user in the database or data source as needed
    }


    // MARK: User Actions

    func follow(user otherUser: User) {
        self.userIsFollowed = true  // Set this to true when following
        // TODO: Backend Synchronization
        // TODO: Error Handling
    }

    func unfollow(user otherUser: User) {
        self.userIsFollowed = false  // Set this to false when unfollowing
        // TODO: Backend Synchronization
        // TODO: Error Handling
    }

    func addCloseFriend(user otherUser: User) {
        self.userIsCloseFriend = true
        // TODO: Backend Synchronization
        // TODO: Error Handling
    }

    func removeCloseFriend(user otherUser: User) {
        self.userIsCloseFriend = false
        // TODO: Backend Synchronization
        // TODO: Error Handling
    }

    func isCloseFriend(of otherUser: User) -> Bool {
        user?.closeFriends.contains(otherUser.id) ?? false
    }

    // UI Update is implicitly handled by SwiftUI as 'user' is a @Published property.

    
    func updateProfilePicture(newImageURL: String) {
        guard var currentUser = user else { return }
        currentUser.profilePicture = newImageURL
        user = currentUser // Update the user with modified data
    }

    func updateSelectedTheme(_ theme: Theme) {
        guard var currentUser = user else { return }
        currentUser.selectedTheme = theme
        user = currentUser // Update the user with modified data
    }

        // For search query
//    func filteredUsers(_ query: String) -> [User] {
//        let filtered = users.filter { $0.username.lowercased().contains(query.lowercased()) }
//        return Array(filtered.prefix(10)) // Return up to 10 users
//    }

    // Add any additional methods needed for handling user interactions or updating the user's profile.
}

extension UserViewModel {
    func purchaseTheme(for user: User, theme: Theme) {
        // Check if the theme is purchasable
        if theme.approved && !theme.purchasers.contains(user.id) {
            // Process the purchase (payment logic)
            // ...

            var updatedTheme = theme
            updatedTheme.purchase(by: user)

            // Update the theme in your theme collection
            // ...
        }
    }

    func changeTheme(for user: User, to newTheme: Theme) {
        // Update user's selected theme
        // ...
    }
}
