//
//  Post.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation
import SwiftUI

// Define an enumeration to represent the different post types


// Define the base Post class

// If you're going to decode/encode the Post class from/to JSON, you should make it Codable.
// ObservableObject is used to observe instance of this class in SwiftUI.
class Post: Identifiable, ObservableObject {
    var id: UUID
    var author: User  // This 'User' class also needs to be Codable if 'Post' is Codable.
    var timestamp: Date
    var textContent: String? // used for text posts, optional for others
    var images: [String]? // URLs or identifiers for images, if any
    var videos: [String]? // URLs or identifiers for videos, if any
    // Can close friends post
    // Can be NSFW post 
    @Published var socialInteractions: SocialInteractionsManager  // Needs to be Codable, if it's a class/struct with custom types.

    // CodingKeys enum is needed if you're going to decode/encode from/to a different naming convention in JSON.
//    enum CodingKeys: String, CodingKey {
//        case id, author, timestamp, type, socialInteractions
//    }

    // Regular initializer (not part of Codable)
    init(id: UUID = UUID(), author: User, timestamp: Date, textContent: String?, images: [String]?, videos: [String]?, socialInteractions: SocialInteractionsManager) {
        self.id = id
        self.author = author
        self.timestamp = timestamp
        self.textContent = textContent
        self.images = images
        self.videos = videos
        self.socialInteractions = socialInteractions
    }
}
extension Post {
    enum PostType: String, Codable {
        case text
        case image
        case video
        case undefined  // Here is an additional case for undefined or mixed content types
        // ... any other types of content ...
    }

    var type: PostType {
        // Logic to determine the type based on content
        if let images = images, !images.isEmpty, videos == nil {
            return .image
        } else if let videos = videos, !videos.isEmpty, images == nil {
            return .video
        } else if textContent != nil, images == nil, videos == nil {
            return .text
        } else {
            return .undefined // or some other default case
        }
    }
}


// Your SocialInteractionsManager and User classes or structs should also conform to Codable.
class SocialInteractionsManager {
    var comments: [Comment]
    var likes: [User]
    var reposts: [User]
    var quotes: [Quote]

    // Here, you initialize all properties with default values (empty arrays)
    // You could also allow these to be set with initializers, if needed.
    init(comments: [Comment] = [], likes: [User] = [], reposts: [User] = [], quotes: [Quote] = []) {
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.quotes = quotes
    }

    // Computed properties for counts can also reside here
    var likesCount: Int {
        return likes.count
    }
    
    var repostsCount: Int {
        return reposts.count
    }

    // Initializer, etc.

    func addComment(_ comment: Comment) {
        comments.append(comment)
    }

    func addQuote(_ quote: Quote) {
        quotes.append(quote)
    }

    // Other functionalities like 'like', 'repost', etc.
    
    // Now, the creation of a Post instance and interaction with its social features look cleaner and more organized.
    
//    let interactionsManager = SocialInteractionsManager()
//
//    // Create a new post with the interactions manager.
//    let newPost = Post(author: someUser, timestamp: Date(), type: .text, socialInteractions: interactionsManager)
//
//    // Interact with the post's social features.
//    newPost.socialInteractions.addComment(someComment)
//    newPost.socialInteractions.addQuote(someQuote)

}

// Dont know if we need to do this

// Define a subclass for text posts
//class TextPost: Post {
//    var content: String  // Specific to TextPost
//    
//    init(author: User, content: String, timestamp: Date) {
//        self.content = content
//        let interactions = SocialInteractionsManager()  // Create a default interactions manager
//        super.init(author: author, timestamp: timestamp, type: .text, socialInteractions: interactions)
//    }
//    
//    // ... any text post-specific methods ...
//}

// Dont know if we need to do this
//class ImagePost: Post {
//    var imageContent: [String]  //  this is a placeholder for image data
//    var caption: String?  // Optional caption specific to images
//    
//    init(author: User, timestamp: Date, imageContent: [String], caption: String? = nil) {
//        self.imageContent = imageContent
//        self.caption = caption
//        let interactions = SocialInteractionsManager()  // Create a default interactions manager
//        super.init(author: author, timestamp: timestamp, type: .image, socialInteractions: interactions)
//    }
//    
//    // ... any image post-specific methods ...
//}

// Dont know if we need to do this
//class VideoPost: Post {
//    var videoContent: [URL]
//    var videoDuration: TimeInterval  // Duration in seconds
//    var caption: String?  // Optional caption specific to videos
//    
//    init(author: User, timestamp: Date, videoContent: [URL], videoDuration: TimeInterval, caption: String? = nil) {
//        self.videoContent = videoContent
//        self.videoDuration = videoDuration
//        self.caption = caption
//        let interactions = SocialInteractionsManager()  // Create a default interactions manager
//        super.init(author: author, timestamp: timestamp, type: .video, socialInteractions: interactions)
//    }
//    
//    // ... any video post-specific methods ...
//}

