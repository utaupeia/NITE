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
    
    init(id: UUID = UUID(), author: User, text: String, timestamp: Date, replies: [Comment] = []) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
        self.replies = replies
    }
    
    // Function to add a reply to a comment
    mutating func addReply(_ reply: Comment) {
        replies.append(reply)
    }
}
