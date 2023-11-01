//
//  StoryViewModel.swift
//  niteclub
//
//  Created by +++ on 10/26/23.
//

import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
    // Published property that the view can observe and update itself when changes occur
    @Published var currentStoryGroup: StoryGroup?
    @Published var currentStory: StoryItem?
    
    // Private properties
    private var allStoryGroups: [StoryGroup] = [] // All story groups, possibly fetched from a server
    private var currentGroupIndex = 0
    
    // Timer to automatically advance to the next story
    private var storyTimer: Timer?

    
    
    // Load dummy data for demonstration purposes
    private func loadDummyData() {
        // Create some dummy users
        let alice = User(username: "Alice", profilePicture: "image7", following: [], followers: [], lurking: 7832, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
        let bob = User(username: "Bob", profilePicture: "image3", following: [], followers: [], lurking: 7832, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")
        let charlie = User(username: "Charlie", profilePicture: "image1", following: [], followers: [], lurking: 7832, status: .default, acquiredThemes: [sampleTheme], selectedTheme: sampleTheme, dateJoined: Date(), location: "USA")

        // Create some stories for each user
        let alicesStories = [
            StoryItem(author: alice, mediaURL: "image2", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: []),
            StoryItem(author: alice, mediaURL: "image4", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: [])
        ]

        let bobsStories = [
            StoryItem(author: bob, mediaURL: "image1", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: []),
            StoryItem(author: bob, mediaURL: "image9", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: [])
        ]

        let charliesStories = [
            StoryItem(author: charlie, mediaURL: "image6", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: []),
            StoryItem(author: charlie, mediaURL: "image5", duration: 5, postedDate: Date(), expiresDate: Date().addingTimeInterval(86400), likes: [], replies: [])
        ]

        // Create story groups from the users' stories
        let alicesStoryGroup = StoryGroup(user: alice, stories: alicesStories)
        let bobsStoryGroup = StoryGroup(user: bob, stories: bobsStories)
        let charliesStoryGroup = StoryGroup(user: charlie, stories: charliesStories)

        // Add the story groups to the allStoryGroups array
        allStoryGroups = [alicesStoryGroup, bobsStoryGroup, charliesStoryGroup]

        // Set the initial current story group and story
        if let firstGroup = allStoryGroups.first {
            currentStoryGroup = firstGroup
            currentStory = firstGroup.currentStory()
        }
    }
    
    init() {
        loadDummyData()  // Now it's okay to call here since it's not private.
    }

    func markStoryAsSeen(story: StoryItem) {
        // Your logic to mark a story as seen
        // This could involve setting a 'seen' flag on the story and updating any related properties or models
    }

    // Move to the next story in the current story group
    func nextStory() {
        // Cancel the current timer if one is running
        storyTimer?.invalidate()
        
        // Logic to move to the next story or the next story group if the current one is finished
        if let currentGroup = currentStoryGroup {
            if currentGroup.hasMoreStories() {
                currentGroup.nextStory()
                currentStory = currentGroup.currentStory()
                restartTimer()
            } else {
                nextStoryGroup()
            }
        }
    }
    
    // Move to the next story group
    func nextStoryGroup() {
        if currentGroupIndex < allStoryGroups.count - 1 {
            currentGroupIndex += 1
            currentStoryGroup = allStoryGroups[currentGroupIndex]
            currentStory = currentStoryGroup?.currentStory()
            restartTimer()
        }
    }
    
    // Restart the timer for the current story's duration
    private func restartTimer() {
        let duration = currentStory?.duration ?? 5 // Default to 5 seconds if for some reason there's no current story
        
        storyTimer?.invalidate() // Cancel the current timer if one is running
        storyTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.nextStory() // Move to the next story when the timer fires
        }
    }
    
    // Handle any cleanup when the view disappears
    func viewDidDisappear() {
        storyTimer?.invalidate() // Stop the timer if the view is disappearing
    }
}

