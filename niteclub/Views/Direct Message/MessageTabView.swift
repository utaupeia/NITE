//
//  MessageTabView.swift
//  niteclub
//
//  Created by +++ on 1/22/24.
//

import SwiftUI

enum NavigationItem: Hashable {
    case messageTab
    // ... other navigation items
}
// MARK: HIDE TABBAR STATE UPON DM VISIBILITY
struct MessageTabView: View {
    @State private var selectedTab = 0
    @State private var selectedConversation: Conversation?

    @Binding var isDMVisible: Bool
    @EnvironmentObject var tabBarState: TabBarState

    var body: some View {
        ZStack {
//            Color.gray.ignoresSafeArea()
            TabView(selection: $selectedTab) {
                DirectMessageView(conversations: SampleData.sampleConversations, onConversationSelected: { conversation in
                    self.selectedConversation = conversation
                    self.selectedTab = 1 // Switch to DirectMessageThread tab
                })
                .tag(0)

                if let conversation = selectedConversation {
                    let viewModel = ConversationViewModel(conversation: conversation)
                    DirectMessageThread(viewModel: viewModel, selectedTab: $selectedTab)
                        .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            if selectedTab == 0 {
                backButton
                    .padding(.top, 60)
            }
        }
        .ignoresSafeArea()
        .onAppear{
                tabBarState.isHidden = true
        }
    }
    var backButton: some View {
        VStack {
            HStack {
                Button(action: { withAnimation(.spring()){ isDMVisible = false}}) {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                        .frame(width: 40, height: 30)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .overlay(
                            Image("Cancel")
                                .renderingMode(.template)
                                .foregroundColor(.white.opacity(0.5))
                        )
                }
                Spacer()
                
                Button(action: { withAnimation(.spring()){ }}) {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 60, height: 30)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.5))
                        )
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MessageTabView(isDMVisible: .constant(true))
        .environmentObject(TabBarState())
}

extension SampleData {
    static var sampleConversations: [Conversation] {
        // Sample messages for mock conversations
        let message1 = DirectMessage(
            id: UUID(),
            content: MessageContent(text: "Hey, how are you?", attachments: nil),
            sender: SampleData.userEmma,
            recipient: [SampleData.userJohn], // Recipient is John
            timestamp: Date(),
            readStatus: [SampleData.userEmma.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
            likes: []
        )
        let message2 = DirectMessage(
            id: UUID(),
            content: MessageContent(text: "no thanks?", attachments: nil),
            sender: SampleData.userEmma,
            recipient: [SampleData.userJohn], // Recipient is John
            timestamp: Date(),
            readStatus: [SampleData.userEmma.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
            likes: []
        )
        let message3 = DirectMessage(
            id: UUID(),
            content: MessageContent(text: "Hey, how are you?", attachments: nil),
            sender: SampleData.bobby,
            recipient: [SampleData.userJohn], // Recipient is John
            timestamp: Date(),
            readStatus: [SampleData.bobby.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
            likes: []
        )
        let message4 = DirectMessage(
            id: UUID(),
            content: MessageContent(text: "no thanks?", attachments: nil),
            sender: SampleData.carrie,
            recipient: [SampleData.userJohn], // Recipient is John
            timestamp: Date(),
            readStatus: [SampleData.carrie.id: false, SampleData.userJohn.id: false], // Emma has read, John hasn't
            likes: []
        )
        let message5 = DirectMessage(
            id: UUID(),
            content: MessageContent(text: "Hey, how are you?", attachments: nil),
            sender: SampleData.faye,
            recipient: [SampleData.userJohn], // Recipient is John
            timestamp: Date(),
            readStatus: [SampleData.faye.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
            likes: []
        )


        // Sample conversation between John and Emma
        let conversation1 = Conversation( id: UUID(), participants: [userJohn, userEmma], messages: [message1, message2], lastMessageDate: Date())

        let conversation2 = Conversation( id: UUID(), participants: [userJohn, SampleData.bobby], messages: [message3], lastMessageDate: Date())

        let conversation3 = Conversation( id: UUID(), participants: [userJohn, SampleData.carrie], messages: [message4], lastMessageDate: Date())

        let conversation4 = Conversation( id: UUID(), participants: [userJohn, SampleData.faye], messages: [message5], lastMessageDate: Date())

        // You can create more conversations similarly
        // ...

        return [conversation1, conversation2, conversation3, conversation4] // Add more conversations as you create them
    }
}
