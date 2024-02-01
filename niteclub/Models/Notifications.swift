//
//  Notifications.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

// make notifications grouped by date up to ONE WEEK [ tpday , yesterday , 2 days ago , etc ... ]

// Enum representing the different types of notifications.
// Each case corresponds to a different event that might happen in your app.
enum NotificationType {
    case postLike(post: Post)         // for Text / Image / Video Posts
    case postRepost(post: Post)       // for Text / Image / Video Posts
    case postComment(post: Post)      // for Text / Image / Video Posts
    case postQuote(post: Post)        // for Text / Image / Video Posts
    case storyLike(story: StoryItem)       // for Story Posts
    case storyReply(story: StoryItem)      // for Story Posts
    case themePurchase(theme: Theme)   // for Users who created a theme
    case newTheme(theme: Theme)         // for when Users you follow, created a theme
    case follow(user: User)           // user who followed you
    case mention(postID: UUID)          // post in which you were mentioned
    case commentLike(comment: Comment)   // for any comment you have left
    case commentReply(comment: Comment)  // for any comment you have left, which was replied to...
    case musicLike(musicID: UUID)       // for Users who have shared music
    case musicRepost(musicID: UUID)     // for Users who have shared music
    // ... any other notification types
}

// A single notification.
struct UserNotification: Identifiable {
    var id: UUID                        // Unique identifier for the notification
    var type: NotificationType          // Type of notification
    var timestamp: Date                 // When the notification was issued
    var isRead: Bool                    // Whether or not the notification has been read

    // Depending on your design, you might include additional metadata
    // related to the notification here, potentially including navigation information.

    init(id: UUID = UUID(), type: NotificationType, timestamp: Date, isRead: Bool = false) {
        self.id = id
        self.type = type
        self.timestamp = timestamp
        self.isRead = isRead
    }
    
    // ... any additional methods or computed properties ...
}

// Usage:
// let newNotification = UserNotification(
//     type: .postLike(postID: somePostID),
//     title: "Your post was liked",
//     message: "Someone liked your post!",
//     timestamp: Date()
// )
