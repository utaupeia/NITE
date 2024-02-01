//
//  Comment.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import Foundation

struct Comment: Identifiable {
    var id: UUID
    var author: User // Renamed from 'user'
    var text: String // Renamed from 'caption'
    var timestamp: Date
    var replies: [Comment]
    var likes: [User] // Added for storing likes

    
    init(id: UUID = UUID(), author: User, text: String, timestamp: Date, replies: [Comment] = [], likes: [User] = []) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
        self.replies = replies
        self.likes = likes
    }
}
// Whenever the post updates its comments
// commentViewModel.updateComments(from: postViewModel)

