//
//  PopupPostView.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI

struct PopupPostView: View {
    var postViewModel: PostViewModel
    var namespace: Namespace.ID
    var onDismiss: () -> Void
@State private var showComments = false
    var body: some View {
        ZStack {
            Blur(style: .dark)
                .onTapGesture {
                    withAnimation(.spring()) {
                        onDismiss()
                    }
                }
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12) {
                // Post Content
                Group {
                    // Display the post's image, video, or text content
                    // For example, you might have different views based on post type
                    if let images = postViewModel.post.images, !images.isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack(alignment: .topLeading) {
                                ScrollView(.horizontal, showsIndicators: false) { // Use .vertical if you prefer a vertical layout
                                    HStack {
                                        ForEach(images, id: \.self) { imageName in
                                            // Assuming imageName is a String that represents the name of the image
                                            Image(imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit) // Adjust content mode as needed
                                                .cornerRadius(10) // Rounded corners for styling
                                            // Add other modifiers for styling as needed
                                        }
                                    }
                                    .padding(6)
                                    // Space between images
                                    
                                }
                                .frame(height: showComments ? 200 : 600)
                                // button links to profile
                                Button(action: {
                                    // This assumes that your Post has a reference to the user who created it
                                    withAnimation(.spring) {
    //                                    postsViewModel.selectUser(viewModel.post.author)
                //                        navigationPath.append(viewModel.post.author) // Append to the navigation path
    //                                    navigationPath.append(viewModel.post.author)  // Trigger navigation

                                    }
                                }) {
                                    Image(postViewModel.post.author.profilePicture)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 36, height: 60)
                                        .cornerRadius(6)
                                        .padding(12)
                                        .clipped()
                                    
                                }
                            }
                            Button(action: {
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
//                                            postsViewModel.selectUser(viewModel.post.author)
                                }
                            }) {
                                Text(postViewModel.post.author.username)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(6)
                            }
                            
                            Text(postViewModel.post.textContent ?? "")
                                    .font(.system(size: 13))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(1.0))
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 6)

                        }
                    } else if let videos = postViewModel.post.videos, !videos.isEmpty {
                        // Display video content
                    } else {
                        // Display text content
                        HStack(alignment: .top) {
                            
                            // button links to profile
                            Button(action: {
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
//                                    postsViewModel.selectUser(viewModel.post.author)
            //                        navigationPath.append(viewModel.post.author) // Append to the navigation path
//                                    navigationPath.append(viewModel.post.author)  // Trigger navigation

                                }
                            }) {
                                Image(postViewModel.post.author.profilePicture)
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
//                                            postsViewModel.selectUser(viewModel.post.author)
                                        }
                                    }) {
                                        Text(postViewModel.post.author.username)
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
                                    
                                Text(postViewModel.post.textContent ?? "")
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
                        .padding(6)
                    }
                }
                .matchedGeometryEffect(id: postViewModel.id, in: namespace)

                // Additional Post Details
                VStack(alignment: .leading) {
                    // User info, timestamp, etc.


                    // Likes, comments, reposts count
                    HStack {
                        Text("Likes: \(postViewModel.getLikes().count)")
                        // button for showing array of users that liked
                        Text("Comments: \(postViewModel.getComments().count)")
                        // button for showing array of comments
                        Text("Reposts: \(postViewModel.getReposts().count)")
                        // button for showing array of users that reposts (including quote count)
                    }
                }

                // Interactions: Like, Comment, Repost, Share, etc.
                HStack {
                    Button("Like") {
                        // Handle like action
                    }
                    Button("Comment") {
                        // Handle comment action
                    }
                    Button("Repost") {
                        // Handle repost action
                    }
                    // Add more as needed
                }

                Spacer()

                // Dismiss Button
                Button("Dismiss") {
                    withAnimation(.spring()) {
                        onDismiss()
                    }
                }
                Button("comments") {
                    withAnimation(.spring()) {
                        showComments.toggle()
                    }
                }
            }
        }
    }
}

let mockPostViewModel = PostViewModel(post: textPost, currentUser: User(id: UUID(), username: "Current User", profilePicture: "placeholderImage", following: [], followers: [], lurking: 100, status: .default, acquiredThemes: [], selectedTheme: ThemeContent(id: UUID(), name: "Sample Theme", content: Theme(themeURL: "placeholderImage"), price: 0.0, creationDate: Date(), approved: true), dateJoined: Date(), location: "Unknown"))

#Preview {
    @Namespace var namespace

    return PopupPostView(postViewModel: mockPostViewModel, namespace: namespace, onDismiss: {})
}
