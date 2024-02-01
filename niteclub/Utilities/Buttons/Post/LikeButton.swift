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
<<<<<<< HEAD
=======
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

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

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
<<<<<<< HEAD
                    Text("\(viewModel.likesCount) \(viewModel.likesCount == 1 ? "Like" : "Likes")")
                        .foregroundColor(.white)

                } else {
                    // Display the heart icon
                    Image(systemName: "suit.heart")
                        .resizable()
                        .frame(width: 24, height: 18)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(.white.opacity(0.05), lineWidth: 1)
                        )
                        .padding(.leading)

=======
                    Text("\(viewModel.likesCount)")
                } else {
                    // Display the heart icon
                    Image(systemName: "heart")
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                }
            }
            .sheet(isPresented: $viewModel.isLikesListVisible) {
                // Your view for displaying the list of likes
                Text("List of Likes")
            }
        }
    }
}


<<<<<<< HEAD

=======
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
