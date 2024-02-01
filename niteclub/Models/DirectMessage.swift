//
//  DirectMessage.swift
//  niteclub
//
//  Created by +++ on 10/25/23.
//

import Foundation


// MARK: MAKE EVERYTHING CODABLE
enum MessageAttachment {
    case image(URL)  // URL to the image resource
    case video(URL)  // URL to the video resource
    // ... any other types of attachments you might have
}

// A single piece of message content, which can have text and/or attachments
struct MessageContent {
    var text: String?  // Text content of the message, if any
    var attachments: [MessageAttachment]?  // Any attachments included with the message
}

// A single direct message.
struct DirectMessage: Identifiable {
    var id: UUID  // Unique identifier for the message
    var content: MessageContent  // The message content
    var sender: User  // The user who sent the message
    var recipient: [User]  // The user(s) who are intended to receive the message
    var timestamp: Date  // When the message was sent
    var readStatus: [UUID: Bool]  // Maps user IDs to their read status
    var likes: [User]  // Users who have liked the message

    init(id: UUID = UUID(), content: MessageContent, sender: User, recipient: [User], timestamp: Date, readStatus: [UUID: Bool]? = nil, likes: [User] = []) {

        self.id = id
        self.content = content
        self.sender = sender
        self.recipient = recipient
        self.timestamp = timestamp
        self.readStatus = readStatus ?? recipient.reduce(into: [UUID: Bool]()) { result, user in
            result[user.id] = (user.id == sender.id)
        }
        self.likes = likes
    }

    // Mark a message as read
    mutating func markAsRead(by userId: UUID) {
        readStatus[userId] = true
    }

    // Handle a user liking the message
    mutating func likeMessage(by user: User) {
        if !likes.contains(where: { $0.id == user.id }) {
            likes.append(user)
            // Trigger a notification to the sender of the message
            // TODO: Notification Service
//            NotificationService.notifyUser(user.id, message: "Your message was liked by \(user.username)")
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
    var groupName: String?
    var groupImage: URL?
    
    // You might also include data for conversation settings, archived messages, etc.

    init( id: UUID = UUID(), participants: [User], messages: [DirectMessage] = [], lastMessageDate: Date) {
        self.id = id
        self.participants = participants
        self.messages = messages
        self.lastMessageDate = lastMessageDate
    }
    
    func getOtherUser() -> User? {
        guard let currentUser = SessionManager.shared.currentUser else { return nil }
        return participants.first { $0 != currentUser }

    }

//    func getOtherUserTheme() -> Theme? {
//        // Find the other user in the conversation
//        let otherUser = participants.first { $0.id != currentUserId }
//
//        // Return the selected theme of the other user
//        return otherUser?.selectedTheme
//    }
    // get a random users theme and display in groupchat settings

    // Send a message in the conversation
    
    mutating func sendMessage(content: MessageContent, sender: User) {
        // Assuming the recipients are all participants except the sender
        let recipients = participants.filter { $0.id != sender.id }

        let newMessage = DirectMessage(
            id: UUID(),
            content: content,
            sender: sender,
            recipient: recipients,
            timestamp: Date(),
            readStatus: recipients.reduce(into: [UUID: Bool]()) { result, user in
                result[user.id] = false
            },
            likes: []
        )
        messages.append(newMessage)
        lastMessageDate = newMessage.timestamp
    }
    
    mutating func deleteMessage(messageId: UUID) {
        messages.removeAll { $0.id == messageId }
    }
    
    func isGroupChat() -> Bool {
        return participants.count > 2
    }
    // New method to add a participant to the group chat
    mutating func addParticipant(_ user: User) {
        if !participants.contains(where: { $0.id == user.id }) {
            participants.append(user)
        }
    }

    // New method to remove a participant from the group chat
    mutating func removeParticipant(_ user: User) {
        participants.removeAll(where: { $0.id == user.id })
    }

    func getOtherParticipant(currentUserId: UUID) -> User? {
        return participants.first { $0.id != currentUserId }
    }


    // Maybe functionality to add/remove participants, archive conversation, etc.
}

// ... your existing User struct ...

class ConversationViewModel: ObservableObject {
    @Published var conversation: Conversation

    init(conversation: Conversation) {
        self.conversation = conversation
    }

    func sendMessage(content: MessageContent, sender: User) {
        conversation.sendMessage(content: content, sender: sender)
        // Notify SwiftUI to update the view
    }

    // ... other functions like deleteMessage, addParticipant, etc.
}
