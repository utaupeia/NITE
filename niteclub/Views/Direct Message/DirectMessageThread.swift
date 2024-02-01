//
//  DirectMessageThread.swift
//  niteclub
//
//  Created by +++ on 12/3/23.
//

import SwiftUI

struct DirectMessageThread: View {
    @ObservedObject var viewModel: ConversationViewModel
    @Binding var selectedTab: Int  // Binding to the selected tab
    @State private var message = ""
    
    private var otherParticipants: [User] {
        viewModel.conversation.participants.filter { $0.id != SessionManager.shared.currentUserId }
    }
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            // Current User Theme if Groupchat, Other user theme if 1 on 1
            if viewModel.conversation.getOtherUser() != nil {
//                Image(otherUser.selectedTheme)
            }
            ScrollView {
                VStack {
                    ForEach(viewModel.conversation.messages.reversed(), id: \.id) { message in
                        HStack {
                            if message.sender == SessionManager.shared.currentUser {
                                
                                // current user's messages aligned to the left
                                Text(message.content.text ?? "")
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(8)
                                    .padding(.horizontal, 4)
                                    .background(Blur(style: .light))
                                    .cornerRadius(15)
                                    .padding(.leading, 12)
                                    .padding(.trailing, 20)
                                    .transition(.move(edge: .leading))
                                
                                Spacer()
                                
                            } else {
                                
                                Spacer()
                                
                                // other user's messages aligned to the right
                                Text(message.content.text ?? "")
                                    .foregroundColor(.white.opacity(1.0))
                                    .padding(8)
                                    .padding(.horizontal, 4)
                                    .background(Blur(style: .dark))
                                    .cornerRadius(15)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 12)
                                    .transition(.move(edge: .trailing))
                            }
                        }
                    }
                }
                .padding(.top, 120)
            }
            VStack {
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 170)
                Spacer()
                
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 90)
                    .rotationEffect(.degrees(180))
            }
            .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .top) {
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = 0
                        }
                    }) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .opacity(0.1)
                            .foregroundColor(.black)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 6)
                            .overlay(
                                Image("Cancel")
                                    .renderingMode(.template)
                                    .foregroundColor(.white.opacity(0.5))
                            )
                    }
                    Spacer()
                    
                    Button(action: {}) {
                        VStack(alignment: .trailing) {
                            
                            if let otherUser = viewModel.conversation.getOtherUser() {
                                Image(otherUser.profilePicture)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 75)
                                    .cornerRadius(9)
                                    .clipped()
                                // other user username
                                Text(otherUser.username)
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                    }
                }
                Spacer()
                HStack(alignment: .bottom) {
                    
                    //MARK: ADD MEDIA BUTTON
                    HStack {
                        TextField("Message...", text: $message, axis: .vertical)
                            .font(.system(size: 18))
                            .foregroundColor(Color.white)
                            .background(.clear)
                            .padding(12)
                            .cornerRadius(30)
                        
                        Button("Send") {
                            guard let currentUser = SessionManager.shared.currentUser else {
                                print("No user logged in")
                                return
                            }
                            let messageContent = MessageContent(text: message, attachments: nil)
                            viewModel.sendMessage(content: messageContent, sender: currentUser)
                            message = ""
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white.opacity(0.5), lineWidth: 0.75)
                    )
                    .padding(.horizontal)
                }
                .padding(.top, 15)
            }
        }
    }
}


func generateSampleMessages(user1: User, user2: User, count: Int) -> [DirectMessage] {
    var messages = [DirectMessage]()

    for i in 1...count {
        let sender = i % 2 == 0 ? user1 : user2
        let recipient = i % 2 != 0 ? [user1] : [user2]
        let messageText = "Sample message \(i)"
        let timestamp = Date().addingTimeInterval(-Double(count - i) * 60) // 1 minute apart

        // Creating read status - assuming all messages are read by both users for simplicity
        var readStatus = [UUID: Bool]()
        readStatus[user1.id] = true
        readStatus[user2.id] = true

        let message = DirectMessage(
            id: UUID(),
            content: MessageContent(text: messageText, attachments: nil),
            sender: sender,
            recipient: recipient,
            timestamp: timestamp,
            readStatus: readStatus,
            likes: []
        )
        messages.append(message)
    }

    return messages
}

let sampleMessages: [DirectMessage] = [
    DirectMessage(id: UUID(), content: MessageContent(text: "Hi John!", attachments: nil), sender: SampleData.userEmma, recipient: [SampleData.userJohn], timestamp: Date().addingTimeInterval(-10000), readStatus: [:], likes: []),
    DirectMessage(id: UUID(), content: MessageContent(text: "Hey Emma, how are you?", attachments: nil), sender: SampleData.userJohn, recipient: [SampleData.userEmma], timestamp: Date().addingTimeInterval(-9000), readStatus: [:], likes: []),
    // Add more messages as needed
]

let sampleConvo = Conversation(
    id: UUID(),
    participants: [SampleData.userEmma],
    messages: sampleMessages,
    lastMessageDate: Date()
)

let sampleMessage1 = DirectMessage(
    id: UUID(),
    content: MessageContent(text: "hihihi hello?", attachments: nil),
    sender: SampleData.userEmma,
    recipient: [SampleData.userJohn], // Recipient is John
    timestamp: Date(),
    readStatus: [SampleData.userEmma.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
    likes: []
)

let sampleMessage2 = DirectMessage(
    id: UUID(),
    content: MessageContent(text: "what are you even doing?", attachments: nil),
    sender: SampleData.userEmma,
    recipient: [SampleData.userJohn], // Recipient is John
    timestamp: Date(),
    readStatus: [SampleData.userEmma.id: true, SampleData.userJohn.id: false], // Emma has read, John hasn't
    likes: []
)
let sampleConversation1 = Conversation(
    id: UUID(),
    participants: [SampleData.userEmma],
    messages: [sampleMessage1, sampleMessage2],
    lastMessageDate: Date().addingTimeInterval(60) // Date of the last message
)
extension ConversationViewModel {
    static var mock: ConversationViewModel {
        ConversationViewModel(conversation: sampleConvo)
    }
}

struct DirectMessageThread_Previews: PreviewProvider {
    static var previews: some View {
        
        DirectMessageThread(viewModel: .mock, selectedTab: .constant(1))
    }
}

//#Preview {
//    DirectMessageThread(viewModel: sampleConvo, selectedTab: .constant(1))
//}

struct DirectMessageConvo: View {
    @State private var message = ""
    @State private var messages: [String] = []
    @State private var selectedImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showGalleryPicker: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tabBarState: TabBarState
//    @ObservedObject var selectedCountModel = SelectedCountModel()
    var body: some View {
        ZStack {
//            OtherUserBackground()
            
            ScrollView {
                ForEach(messages.reversed(), id: \.self) { message in
                    withAnimation(.spring()) {
                        HStack {
//                            Spacer()
                            Text(message)
                                .foregroundColor(.white.opacity(0.75))
                                .padding(8)
                                .background(Blur(style: .dark))
                                .cornerRadius(15)
                                .padding(.leading, 20)
                                .padding(.trailing, 12)
                                .transition(.move(edge: .bottom))
                            Spacer()
                        }
                    }
                }
                .padding(.top, 120)
            }
            VStack {
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 170)
                
                Spacer()
                
                VariableBlurView()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 90)
                    .rotationEffect(.degrees(180))
            }
            .ignoresSafeArea()
            
            VStack {
                    HStack(alignment: .top) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Circle()
                                .frame(width: 30, height: 30)
                                .opacity(0.1)
                                .foregroundColor(.black)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 6)
                                .overlay(
                                    Image("Cancel")
                                        .renderingMode(.template)
                                        .foregroundColor(.white.opacity(0.5))
                                )
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Image("image4")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 75)
                                .cornerRadius(9)
                                .clipped()
                            // other user username
                            Text("username")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .bold))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                    }
                    Spacer()
                        HStack(alignment: .bottom) {
                            if message.count <= 15 {
                                Button(action: {
                                    withAnimation(.spring()) {
                                        showGalleryPicker = true
                                    }
                                }) {
                                    Image("circleoutline")
                                        .renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(.white.opacity(0.5))
                                        .frame(width: 18, height: 18)
                                        .padding(.leading, 24)
                                        .padding(.trailing, 12)
                                        .padding(.vertical, 8)
                                }
                            }
                            
                            HStack {
                                TextField("Message...", text: $message, axis: .vertical)
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.white)
                                    .background(.clear)
                                    .padding(9)
                                    .padding(.leading, 4)
                                    .cornerRadius(30)
                                Spacer()
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 0.75)
                            )
                            .padding(message.count > 15 ? .leading : .init())
                            
                            Button(action: sendMessage) {
                                Image(systemName: "arrow.up.circle")
                                    .resizable()
                                    .foregroundColor(.white.opacity(message.isEmpty ? 0.5 : 1.0))
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 24)
                                    .padding(.leading, 18)
                                    .padding(.vertical, 8)
                            }
                            .disabled(message.isEmpty)
                        }
                        .padding(.top, 15)
                }
            
//            if showGalleryPicker {
//                GalleryPicker(isPresented: $showGalleryPicker)
//                    .transition(.move(edge: .bottom))
//            }
        }
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture()
                .onEnded { _ in
                    self.presentationMode.wrappedValue.dismiss()
                })
        .onAppear {
            tabBarState.isHidden = true
        }
        .onDisappear {
            tabBarState.isHidden = false
        }
    }
    func sendMessage() {
        messages.append(message)
        message = ""
    }
}
//struct DirectMessageConvo_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectMessageConvo()
//            .environmentObject(TabBarState())
//    }
//}
