//
//  DirectMessage.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation

enum MessageAttachment {
    case image(URL)  // URL to the image resource
    case video(URL)  // URL to the video resource
    // ... any other types of attachments you might have
}

// A single piece of message content, which can have text and/or attachments
struct MessageContent {
    var text: String?  // Text content of the message, if any
    var attachments: [MessageAttachment]  // Any attachments included with the message
}

// A single direct message.
struct DirectMessage: Identifiable {
    var id: UUID  // Unique identifier for the message
    var content: MessageContent  // The message content
    var sender: User  // The user who sent the message
    var recipient: User  // The user who is receiving the message
    var timestamp: Date  // When the message was sent
    var isRead: Bool  // Whether the recipient has read the message
    var likes: [User]  // Users who have liked the message

    init(id: UUID = UUID(), content: MessageContent, sender: User, recipient: User, timestamp: Date, isRead: Bool = false, likes: [User] = []) {
        self.id = id
        self.content = content
        self.sender = sender
        self.recipient = recipient
        self.timestamp = timestamp
        self.isRead = isRead
        self.likes = likes
    }

    // Mark a message as read
    mutating func markAsRead() {
        isRead = true
    }

    // Handle a user liking the message
    mutating func likeMessage(by user: User) {
        // Avoid adding a like if the user has already liked the message
        if !likes.contains(where: { $0.id == user.id }) {
            likes.append(user)
        }
    }

    // Handle a user unliking the message
    mutating func unlikeMessage(by user: User) {
        likes.removeAll(where: { $0.id == user.id })
    }
}

// A conversation between two or more users.
struct Conversation: Identifiable {
    var id: UUID  // Unique identifier for the conversation
    var participants: [User]  // All users in the conversation
    var messages: [DirectMessage]  // All messages in the conversation
    var lastMessageDate: Date  // The date of the last message sent in the conversation

    // You might also include data for conversation settings, archived messages, etc.

    init(id: UUID = UUID(), participants: [User], messages: [DirectMessage] = [], lastMessageDate: Date) {
        self.id = id
        self.participants = participants
        self.messages = messages
        self.lastMessageDate = lastMessageDate
    }

    // Send a message in the conversation
    mutating func sendMessage(_ message: DirectMessage) {
        messages.append(message)
        lastMessageDate = message.timestamp
    }

    // Maybe functionality to add/remove participants, archive conversation, etc.
}

// ... your existing User struct ...

