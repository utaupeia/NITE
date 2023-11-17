//
//  TextPostView.swift
//  niteclub
//
//  Created by +++ on 10/20/23.
//

import SwiftUI

struct TextPostView: View {
    
    @ObservedObject var viewModel: PostViewModel  // Changed parameter name to viewModel
    @EnvironmentObject var postsViewModel: PostsViewModel
//    @Binding var navigationPath: NavigationPath  // Add this line

    @State private var navigateToProfile: Bool = false
    @Binding var navigationPath: NavigationPath  // Add this

    var onProfilePictureClicked: ((User) -> Void)?

    var body: some View {
            HStack(alignment: .top) {
                
                // button links to profile 
                Button(action: {
                    // This assumes that your Post has a reference to the user who created it
                    withAnimation(.spring) {
                        postsViewModel.selectUser(viewModel.post.author)
//                        navigationPath.append(viewModel.post.author) // Append to the navigation path
                        navigationPath.append(viewModel.post.author)  // Trigger navigation

                    }
                }) {
                    Image(viewModel.post.author.profilePicture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 60)
                        .cornerRadius(6)
//                        .padding(9)
                        .clipped()
                }
                VStack(alignment: .leading) {
                    
                    HStack {
                        Button(action: {
                            // This assumes that your Post has a reference to the user who created it
                            withAnimation(.spring) {
                                postsViewModel.selectUser(viewModel.post.author)
                            }
                        }) {
                            Text(viewModel.post.author.username)
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.75))
                        }
                        
                        Spacer()
                        
                        Text(viewModel.time)
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.horizontal, 6)
                        
                    }
                    
//                    NavigationLink(destination: ProfileContentTabView(user: viewModel.post.author)) {
                        
                        Text(viewModel.post.textContent ?? "")
                        //                    Text(post.content)
                            .font(.system(size: 13))
                            .fontWeight(.regular)
                            .foregroundColor(.white.opacity(1.0))
                            .multilineTextAlignment(.leading)
//                    }
                }
            }
            .padding(9)
            .background(
                Blur(style: .dark)
                    .cornerRadius(12)
            )
//        NavigationLink(value: viewModel.post.author) {
//            EmptyView()
//        }
//
//        .navigationDestination(for: User.self) { user in
//            ProfileContentTabView(user: user)
//        }

//            .padding(6) sample padding , add in on call in view
        }
    }

// Create a TextPost instance directly, instead of casting from Post to TextPost
let interactionsManager = SocialInteractionsManager()
let sampleTextPost = Post(
    author: sampleUser,
    timestamp: Date(),
    textContent: "This is a sample text post.",
    images: nil,
    videos: nil,
    socialInteractions: interactionsManager
)

let viewModel = PostViewModel(post: sampleTextPost, currentUser: mockCurrentUser)

#Preview {
    TextPostView(viewModel: viewModel, navigationPath: .constant(NavigationPath()))
    
}



