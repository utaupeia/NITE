//
//  LikeButton.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

struct LikeButton: View {
    @ObservedObject var viewModel: PostViewModel

    @State private var selectedStatus: UserStatus = .foreverMember
    @State private var isPostCreator: Bool = true

    var body: some View {
        VStack {
            // Toggle for user status
//            Picker("User Status", selection: $selectedStatus) {
//                Text("Default").tag(UserStatus.default)
//                Text("Member").tag(UserStatus.member)
//                Text("Forever Member").tag(UserStatus.foreverMember)
//                Text("Admin").tag(UserStatus.admin)
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .onChange(of: selectedStatus) {
//                viewModel.toggleUserStatus(forTesting: selectedStatus)
//            }

            // Toggle for being post creator
//            Toggle("Is Post Creator", isOn: $isPostCreator)
//                .onChange(of: isPostCreator) {
//                    viewModel.togglePostCreator(forTesting: isPostCreator)
//                }


            // Like button
            Button(action: {
                withAnimation(.spring()) {
                if viewModel.isPostCreator() {
                    viewModel.handleLikeCountTapForAuthor()
                } else {
                    viewModel.handleLikeButtonTapNonAuthor()
                }
            }
            }) {
                if viewModel.isLikeCountVisible {
                    // Display the like count
                    Text("\(viewModel.likesCount) \(viewModel.likesCount == 1 ? "Like" : "Likes")")
                        .foregroundColor(.white)

                } else {
                    // Display the heart icon
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .padding(10)
            .background(
                Blur(style: .dark)
                    .cornerRadius(30)
            )
            .sheet(isPresented: $viewModel.isLikesListVisible) {
                // Your view for displaying the list of likes
                Text("List of Likes")
            }
        }
    }
}



struct LikesListView: View {
    var likes: [User]

    var body: some View {
        List(likes, id: \.id) { user in
            Text(user.username)
        }
    }
}

let sampleUser2 = User(
    id: UUID(), username: "SampleUser", profilePicture: "",
    following: [], followers: [], lurking: 0,
    status: .member, // or .foreverMember for testing
    acquiredThemes: [], selectedTheme: sampleTheme,
    dateJoined: Date(), location: "", likedPosts: []
)

let samplePost2 = Post(
    id: UUID(), author: sampleUser, timestamp: Date(),
    textContent: "Sample Post", images: nil, videos: nil,
    socialInteractions: SocialInteractionsManager(), repostedBy: nil
)

let viewModel2 = PostViewModel(post: samplePost2, currentUser: sampleUser2)


#Preview {
    LikeButton(viewModel: viewModel2)
}
