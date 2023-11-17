//
//  StoryPost.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

struct StoryItem: Identifiable {
    var id: UUID
    var author: User
    var mediaURL: String
    var duration: TimeInterval // Duration for which the story is shown (e.g., 5 seconds)
    var postedDate: Date
    var expiresAfter: TimeInterval // Duration after which the story expires (e.g., 2 hours)
    var seen: Bool = false
    var likes: [User]
    var replies: [Reply]
    var views: [User]
    var isCloseFriendsOnly: Bool = false
    
    static let expirationDuration: TimeInterval = 7200 // 2 hours in seconds


    // Initialize the StoryItem with necessary data
    init(author: User, mediaURL: String, postedDate: Date, duration: TimeInterval, expiresAfter: TimeInterval = 7200, likes: [User] = [], replies: [Reply] = [], views: [User] = [], isCloseFriendsOnly: Bool = false) {
        self.id = UUID()
        self.author = author
        self.mediaURL = mediaURL
        self.postedDate = postedDate
        self.duration = duration
        self.expiresAfter = StoryItem.expirationDuration
        self.likes = likes
        self.replies = replies
        self.views = views
        self.isCloseFriendsOnly = isCloseFriendsOnly
    }

    func isExpired() -> Bool {
        return Date().timeIntervalSince(postedDate) > expiresAfter
    }


    mutating func addView(user: User) {
        if !isExpired() && !views.contains(where: { $0.id == user.id }) {
            views.append(user)
        }
    }

    // Here, you can add functions to handle likes, replies, and other interactions with the story item.
    // ...
}
extension StoryItem {
    var remainingTime: TimeInterval {
        let elapsed = Date().timeIntervalSince(postedDate)
        return max(expiresAfter - elapsed, 0)
    }
}

struct Reply {
    var user: User
    var message: String
    var date: Date
}

extension StoryGroup {
    var totalDuration: TimeInterval {
        return stories.reduce(0) { $0 + $1.duration }
    }
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
    func currentStory(for viewer: User) -> StoryItem? {
        while currentStoryIndex < stories.count {
            let story = stories[currentStoryIndex]
            if !story.isExpired() &&
               (!story.isCloseFriendsOnly || story.author.isCloseFriend(of: viewer)) {
                return story
            }
            currentStoryIndex += 1
        }
        return nil
    }

//    func currentStory() -> StoryItem? {
//        if currentStoryIndex < stories.count {
//            return stories[currentStoryIndex]
//        }
//        return nil // Or handle this case as appropriate for your app's logic.
//    }

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
