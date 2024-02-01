//
//  DirectMessageView.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI

struct DirectMessageView: View {
    @State var conversations: [Conversation] // Array of conversations
    var onConversationSelected: (Conversation) -> Void // Closure to handle selection

    var body: some View {
        ZStack {
//            Color.gray.ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(conversations, id: \.id) { conversation in
                        Button(action: {                                    withAnimation(.spring()) {
                            onConversationSelected(conversation)
                        }
                        }) {
                            DMview(conversation: conversation)
                        }
                    }

                }
                .padding(.top, 50)
            }
        }
    }
}

#Preview {
    DirectMessageView(conversations: SampleData.sampleConversations) { conversation in
        // Dummy implementation for preview purposes
        print("Selected conversation: \(conversation.id)")
    }
}

let sampleConversation2 = Conversation(
    id: UUID(),
    participants: [SampleData.userEmma, sampleUser2],
    messages: [sampleMessage1, sampleMessage2],
    lastMessageDate: Date().addingTimeInterval(60) // Date of the last message
)
