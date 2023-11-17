//
//  DMview.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI

import SwiftUI

struct DMview: View {
    var conversation: Conversation
    var otherUser: User

    var body: some View {
        let lastMessage = conversation.messages.last!

        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .top) {
                // Profile picture
                Image(otherUser.profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 70)
                    .cornerRadius(6)
                    .clipped()

                Spacer()

                // Timestamp
                Text(lastMessage.timestamp, formatter: DateFormatter.shortTime)
                    .font(.system(size: 12))
                    .textCase(.uppercase)
                    .foregroundColor(.white.opacity(0.5))
            }

            VStack(alignment: .leading) {
                // Username
                Text(otherUser.username)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)

                // Last message
                Text(lastMessage.content.text ?? "Attachment")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white, lineWidth: 0.75)
        )
        .padding(.horizontal, 9)
    }
}

// Custom formatter for the timestamp
extension DateFormatter {
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}

let sampleMessage = DirectMessage(
    id: UUID(),
    content: MessageContent(text: "Hey, how are you?", attachments: nil),
    sender: SampleData.userEmma,
    recipient: sampleUser2,
    timestamp: Date(),
    isRead: true,
    likes: []
)
let sampleConversation = Conversation(
    currentUserID: sampleUser2.id,
    id: UUID(),
    participants: [SampleData.userEmma, sampleUser2],
    messages: [sampleMessage],
    lastMessageDate: Date()
)


#Preview {
    DMview(conversation: sampleConversation, otherUser: SampleData.userEmma)
}
