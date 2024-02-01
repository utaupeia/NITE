//
//  DMview.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI

struct DMview: View {
    var conversation: Conversation

    var body: some View {
        //            Color.gray
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .top) {
                    ForEach(otherParticipants, id: \.id) { user in
                        Image(user.profilePicture) // Ensure this string corresponds to an image name
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    
                    Spacer()
                    
                    // Timestamp
                    Text(lastMessageTime)
                        .font(.system(size: 12))
                        .textCase(.uppercase)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                VStack(alignment: .leading) {
                    // Usernames
                    ForEach(otherParticipants, id: \.id) { user in
                        Text(user.username)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    // Last message
                    Text(lastMessageText)
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

    private var currentUser: User? {
        SessionManager.shared.currentUser
    }

    private var otherParticipants: [User] {
        guard let currentUser = SessionManager.shared.currentUser else {
            return conversation.participants
        }
        return conversation.participants.filter { $0.id != currentUser.id }
    }

    private var lastMessageText: String {
        // Extract the text of the last message
        return conversation.messages.last?.content.text ?? ""
    }

    private var lastMessageTime: String {
        // Format the timestamp of the last message
        if let lastMessage = conversation.messages.last {
            return DateFormatter.localizedString(from: lastMessage.timestamp, dateStyle: .none, timeStyle: .short)
        }
        return ""
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

let currentUserID = SessionManager.shared.currentUserId ?? UUID()

let sampleMessage = DirectMessage(
    id: UUID(),
    content: MessageContent(text: "Hey, how are you?", attachments: nil),
    sender: SampleData.userEmma,
    recipient: [SampleData.userJohn], // Recipient is John
    timestamp: Date(),
    readStatus: [SampleData.userEmma.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
    likes: []
)

let sampleConversation = Conversation(
    id: UUID(),
    participants: [SampleData.userEmma, SampleData.userJohn],
    messages: [sampleMessage],
    lastMessageDate: sampleMessage.timestamp
)

#Preview {
    DMview(conversation: sampleConversation)
}
