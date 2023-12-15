//
//  UserViewModel.swift
//  niteclub
//
//  Created by +++ on 10/27/23.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var user: User

    // UI-related properties
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    // Properties extracted from 'User' for the view
    var username: String { user.username }
    var profilePicture: String { user.profilePicture }
    var followerCount: Int { user.followers.count }
    var followingCount: Int { user.following.count }
    var lurkingCount: Int { user.lurking }
    var location: String { user.location }
    // For 'invitedBy' and 'link', I'm providing placeholders as it's unclear how these would be derived from the User model.
    var invitedBy: String { "OTHERUSER" }  // Modify to username of user
    var link: String { "www.website" }  // Optional entry from members
    var selectedTheme: ThemeContent { user.selectedTheme }
    
    private var fetchUser: AnyCancellable?

    init(user: User) {
        self.user = user
    }

    // MARK: Data Fetching

    func fetchUserData() {
        guard !isLoading else { return }
        
        isLoading = true
        // Here, you would implement the actual data fetching from a server or local database.
        // For now, I'll simulate a data fetch with a delay.
        fetchUser = UserRepository.getUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished: break
                case .failure(let failure): print(failure.localizedDescription)
                }
            }, receiveValue: { [weak self] item in
                self?.user = item.result
            })
//        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
//            // Simulate data update
//            self.user.username += " Updated"
//            self.isLoading = false
//        }
    }
    
    func toggleUserProfile(to newUser: User) {
        self.user = newUser
    }

    func updateUser(_ newUser: User) {
        user = newUser
    }


    // MARK: User Actions

    func follow(user otherUser: User) {
        // Logic to follow another user, potentially making a network request and updating 'user'
    }

    func unfollow(user otherUser: User) {
        // Logic to unfollow another user, similar to 'follow(user:)'
    }

    func updateProfilePicture(newImageURL: String) {
        // Logic to update the user's profile picture
        self.user.profilePicture = newImageURL
    }

    func updateSelectedTheme(_ theme: ThemeContent) {
        // Logic to update the user's theme
        self.user.selectedTheme = theme
    }

    // Add any additional methods needed for handling user interactions or updating the user's profile.
}


