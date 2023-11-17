//
//  DirectMessageView.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI

struct DirectMessageView: View {
    @State var conversations: [Conversation] // Array of conversations
    @State var currentUserID: UUID // ID of the current user

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(conversations, id: \.id) { conversation in
                        if let otherUser = conversation.participants.first(where: { $0.id != currentUserID }) {
                            DMview(conversation: conversation, otherUser: otherUser)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    DirectMessageView(conversations: [sampleConversation1, sampleConversation2], currentUserID: SampleData.userJohn.id)
}




let sampleConversation2 = Conversation(
    currentUserID: SampleData.userEmma.id,
    id: UUID(),
    participants: [SampleData.userEmma, sampleUser2],
    messages: [sampleMessage1, sampleMessage2],
    lastMessageDate: Date().addingTimeInterval(60) // Date of the last message
)
