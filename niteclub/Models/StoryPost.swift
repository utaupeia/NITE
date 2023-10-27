//
//  StoryPost.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

// Single entity representing a piece of story content.
struct StoryItem: Identifiable {
    var id: UUID
    var author: User
    var mediaURL: String
    var duration: TimeInterval
    var postedDate: Date
    var expiresDate: Date
    var seen: Bool = false
    var likes: [User]
    var replies: [Reply]

    // Initialize the StoryItem with necessary data
    init(author: User, mediaURL: String, duration: TimeInterval, postedDate: Date, expiresDate: Date, likes: [User] = [], replies: [Reply] = []) {
        self.id = UUID()
        self.author = author
        self.mediaURL = mediaURL
        self.duration = duration
        self.postedDate = postedDate
        self.expiresDate = expiresDate
        self.likes = likes
        self.replies = replies
    }

    // Here, you can add functions to handle likes, replies, and other interactions with the story item.
    // ...
}

// Reply structure remains unchanged.
struct Reply {
    var user: User
    var message: String
    var date: Date
}

class StoryGroup: Identifiable {
    var id: UUID
    var user: User // Assuming each group is associated with one user.
    private(set) var stories: [StoryItem]

    // We may also want to track the current story index.
    private var currentStoryIndex = 0

    init(user: User, stories: [StoryItem]) {
        self.id = UUID()
        self.user = user
        self.stories = stories
    }

    // Function to get the current story
    func currentStory() -> StoryItem? {
        if currentStoryIndex < stories.count {
            return stories[currentStoryIndex]
        }
        return nil // Or handle this case as appropriate for your app's logic.
    }

    // Function to advance to the next story
    func nextStory() {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
        }
    }

    // Function to regress to the previous story
    func previousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        }
    }

    // Function to check if there are more stories to view in this group
    func hasMoreStories() -> Bool {
        return currentStoryIndex < stories.count - 1
    }

    // You can also add functions here to handle the expiry of stories, marking stories as seen, and other relevant operations.
    // ...
}
