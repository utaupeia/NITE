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
    
    @State private var quote: String = ""
    @StateObject var commentViewModel = CommentViewModel() // Shared ViewModel
    @State private var showComments = false // State to control the visibility of comments

    @State private var showQuotes = false
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
                // Quote Content shown for members only
                
                if !(showComments || !showQuotes) {
                        TextField("quote...", text: $quote, axis: .vertical)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(.white)
                            )
                            .padding(.horizontal, 12)
                    }
                
                // Post Content
                Group {
                    // Display the post's image, video, or text content
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
                                .frame(height: showComments ? 200 : 500)
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
                //                VStack(alignment: .leading) {
                //                    // User info, timestamp, etc.
                //
                //
                //                    // Likes, comments, reposts count
                //                    HStack {
                //                        Text("Likes: \(postViewModel.getLikes().count)")
                //                        // button for showing array of users that liked
                //                        Text("Comments: \(postViewModel.getComments().count)")
                //                        // button for showing array of comments
                //                        Text("Reposts: \(postViewModel.getReposts().count)")
                //                        // button for showing array of users that reposts (including quote count)
                //                    }
                //                }
                if showComments {
                        CommentListView(viewModel: commentViewModel)
                            .transition(.move(edge: .bottom)) // Optional transition effect
                    .frame(width: .infinity)
                    .padding(6)
                    .transition(.move(edge: .bottom))
                }
                Spacer()
            }
            .padding(.top, 60)
            VStack {
            // Interactions: Like, Comment, Repost, Share, etc.
            HStack {
                Button(action: {
                    withAnimation(.spring()) {
                        onDismiss()
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(9)
                        .background(
                            Blur(style: .dark)
                                .cornerRadius(24)
                        )
                        .padding(.horizontal)
                }
                
                Spacer()
                
                Button("Quotes") {
                    // Handle quote action
                    showQuotes.toggle()
                    
                }
                .foregroundColor(showQuotes ? .white : .white.opacity(0.5))
                .padding()
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    // Handle repost action
                    Image(systemName: "arrow.2.circlepath")
                        .foregroundColor(.white)
                        .padding(9)
                        .background(
                            Blur(style: .dark)
                                .cornerRadius(24)
                        )
                        .padding(.horizontal)

                }
            }
                Spacer()

                HStack {
                    
                    
                    LikeButton(viewModel: postViewModel)
                    .padding()
                    
                    Spacer()
                    
                    CommentBarView(viewModel: commentViewModel, showComments: $showComments)

                }
        }

        }
    }
}

let mockPostViewModel = PostViewModel(post: imagePost, currentUser: User(id: UUID(), username: "Current User", profilePicture: "placeholderImage", following: [], followers: [], lurking: 100, status: .default, acquiredThemes: [], selectedTheme: Theme(id: UUID(), name: "Sample Theme", content: ThemeContent(id: UUID(), themeURL: "placeholderImage"), price: 0.0, creationDate: Date(), approved: true), dateJoined: Date(), location: "Unknown"))

#Preview {
    @Namespace var namespace

    return PopupPostView(postViewModel: mockPostViewModel, namespace: namespace, onDismiss: {})
}
