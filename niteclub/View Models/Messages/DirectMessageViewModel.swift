//
//  DirectMessageViewModel.swift
//  niteclub
//
//  Created by +++ on 1/22/24.
//

import Foundation
import Combine

class DirectMessageViewModel: ObservableObject {
    @Published var conversation: Conversation
    @Published var newMessageText: String = ""
    var currentUser: User // Current user property

    // Initialization with a conversation
    init(conversation: Conversation, currentUser: User) {
        self.conversation = conversation
        self.currentUser = currentUser
    }


    // Function to handle sending a new message
//    func sendMessage() {
//        let messageContent = MessageContent(text: newMessageText, attachments: nil)
//        let newMessage = DirectMessage(id: UUID(), content: messageContent, sender: currentUser, timestamp: Date(), isRead: false, likes: [])
//
//        // Update the conversation with the new message
//        conversation.sendMessage(newMessage)
//        
//        // Clear the new message text
//        newMessageText = ""
//    }


    // Add other functionalities as needed, like markAsRead, likeMessage, etc.
}

