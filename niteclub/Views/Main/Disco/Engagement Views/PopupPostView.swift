//
//  PopupPostView.swift
//  niteclub
//
//  Created by +++ on 11/15/23.
//

import SwiftUI
<<<<<<< HEAD
import AVKit

struct PopupPostView: View {
//    var postViewModel: PostViewModel
    @ObservedObject var postViewModel: PostViewModel

    var namespace: Namespace.ID
    var onDismiss: () -> Void
    
    @State private var player: AVPlayer?
    
    @State private var quote: String = ""
    @StateObject var commentViewModel = CommentViewModel() // Shared ViewModel
    @State private var showComments = false // State to control the visibility of comments
    
    @State private var showQuotes = false
    @State private var isRotated: Bool = false
    var videoPlayerSize: CGSize {
        let size = UIScreen.main.bounds
        return CGSize(width: isRotated ? size.height : size.width,
                      height: isRotated ? size.width : size.height / 3.5)
    }
    
=======

struct PopupPostView: View {
    var postViewModel: PostViewModel
    var namespace: Namespace.ID
    var onDismiss: () -> Void
@State private var showComments = false
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
    var body: some View {
        ZStack {
            Blur(style: .dark)
                .onTapGesture {
                    withAnimation(.spring()) {
                        onDismiss()
                    }
                }
                .ignoresSafeArea()
<<<<<<< HEAD
            
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
=======
            VStack(alignment: .leading, spacing: 12) {
                // Post Content
                Group {
                    // Display the post's image, video, or text content
                    // For example, you might have different views based on post type
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
<<<<<<< HEAD
                                .frame(height: showComments ? 200 : 500)
                                // button links to profile
                                Button(action: {
                                    withAnimation(.spring) {
=======
                                .frame(height: showComments ? 200 : 600)
                                // button links to profile
                                Button(action: {
                                    // This assumes that your Post has a reference to the user who created it
                                    withAnimation(.spring) {
    //                                    postsViewModel.selectUser(viewModel.post.author)
                //                        navigationPath.append(viewModel.post.author) // Append to the navigation path
    //                                    navigationPath.append(viewModel.post.author)  // Trigger navigation

>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
<<<<<<< HEAD
                                    //                                            postsViewModel.selectUser(viewModel.post.author)
=======
//                                            postsViewModel.selectUser(viewModel.post.author)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                                }
                            }) {
                                Text(postViewModel.post.author.username)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(6)
                            }
                            
                            Text(postViewModel.post.textContent ?? "")
<<<<<<< HEAD
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.white.opacity(1.0))
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 6)
                            
                        }
                        
                    } else if let videos = postViewModel.post.videos, !videos.isEmpty {
                        VStack(alignment: .leading) {
                            if let videoPlayerViewModel = postViewModel.videoPlayerViewModel {
                                GeometryReader { geometry in
                                    let size = geometry.size
                                    let safeArea = geometry.safeAreaInsets
                                    let videoPlayerSize = CGSize(
                                        width: isRotated ? size.height : size.width,
                                        height: isRotated ? size.width : size.height / 1.0)

                                VideoPlayer(player: videoPlayerViewModel.player)
                                    .overlay(alignment: .topLeading , content: {
                                        Button(action: {
                                            withAnimation(.spring) {}
                                        }) {
                                            Image(postViewModel.post.author.profilePicture)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 36, height: 60)
                                                .cornerRadius(6)
                                                .padding(12)
                                                .clipped()
                                                .opacity(isRotated ? 0 : 1)
                                        }
                                    })
                                    .overlay(alignment: .center, content: {
                                        VideoControlsView(viewModel: videoPlayerViewModel) {
                                            // Implement fullscreen toggle action here
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                isRotated.toggle()
                                            }
                                        }
                                        
                                    })
                                    .frame(width: videoPlayerSize.width, 
                                           height: videoPlayerSize.height)
                                    /// To Avoid other view expansion set its native view height
                                    .frame(width: size.width, 
                                           height: isRotated ? size.height / 3.0 : size.height / 1.0, alignment: .bottomLeading)
                                    .offset(y: isRotated ? -((size.width / 2) + safeArea.bottom) : 0)
                                    /// Go to Normal Position
                                    .rotationEffect(.init(degrees: isRotated ? 90 : 0), anchor: .topLeading)
                                    .zIndex(1000)
                            }
                                .frame(height: isRotated ? .none : UIScreen.main.bounds.height / 3.5)
                                
                            }
                            Button(action: {
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
                                    // postsViewModel.selectUser(viewModel.post.author)
                                }
                            }) {
                                Text(postViewModel.post.author.username)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white.opacity(0.75))
                                    .padding(6)
                                    .opacity(isRotated ? 0 : 1)
                            }
                            
                            Text(postViewModel.post.textContent ?? "")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.white.opacity(1.0))
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 6)
                                .opacity(isRotated ? 0 : 1)
                            
                        }
                        
=======
                                    .font(.system(size: 13))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(1.0))
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 6)

                        }
                    } else if let videos = postViewModel.post.videos, !videos.isEmpty {
                        // Display video content
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                    } else {
                        // Display text content
                        HStack(alignment: .top) {
                            
                            // button links to profile
                            Button(action: {
<<<<<<< HEAD
                                withAnimation(.spring) {}
=======
                                // This assumes that your Post has a reference to the user who created it
                                withAnimation(.spring) {
//                                    postsViewModel.selectUser(viewModel.post.author)
            //                        navigationPath.append(viewModel.post.author) // Append to the navigation path
//                                    navigationPath.append(viewModel.post.author)  // Trigger navigation

                                }
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                            }) {
                                Image(postViewModel.post.author.profilePicture)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 60)
                                    .cornerRadius(6)
<<<<<<< HEAD
                                //                        .padding(9)
=======
            //                        .padding(9)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                                    .clipped()
                            }
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    Button(action: {
                                        // This assumes that your Post has a reference to the user who created it
                                        withAnimation(.spring) {
<<<<<<< HEAD
                                            //                                            postsViewModel.selectUser(viewModel.post.author)
=======
//                                            postsViewModel.selectUser(viewModel.post.author)
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
                                        }
                                    }) {
                                        Text(postViewModel.post.author.username)
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white.opacity(0.75))
                                    }
                                    
                                    Spacer()
                                    
<<<<<<< HEAD
                                    Text(postViewModel.time)
                                        .font(.system(size: 10))
                                        .foregroundColor(.white.opacity(0.5))
                                        .padding(.horizontal, 6)

                                }
                                                                
                                Text(postViewModel.post.textContent ?? "")
                                    .font(.system(size: 13))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(1.0))
                                    .multilineTextAlignment(.leading)
=======
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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
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
<<<<<<< HEAD
                
                if showComments {
                    CommentListView(postViewModel: postViewModel)
//                        .transition(.move(edge: .bottom)) // Optional transition effect
                        .padding(6)
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
                            .padding(.vertical, 6)
                            .padding(.horizontal, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white.opacity(0.05), lineWidth: 1)
                            )
                            .padding(.horizontal)
                    }
                    Spacer()
                    
                    Button(action: {
                        // AUTH USER REPOST THIS  POST = CREATE RE-POST
                    }) {
                        // Handle repost action
                        Image(systemName: "arrow.2.squarepath")
                            .resizable()
                            .frame(width: 24, height: 15)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white.opacity(0.05), lineWidth: 1)
                            )
                            .padding(.horizontal, 6)

                    }
                    Button(action: {withAnimation(.spring()){ showQuotes.toggle()}}) {
                        Image(systemName: "quote.closing")
                            .foregroundColor(showQuotes ? .white : .white.opacity(0.5))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(.white.opacity(0.05), lineWidth: 1)
                            )
                            .padding(.horizontal, 6)
                        
                    }
                }
                Spacer()
                
                HStack( alignment: .bottom, spacing: 0) {
                    LikeButton(viewModel: postViewModel)

                    CommentBar(postViewModel: postViewModel)
                        .padding(.leading, 3)
                    
                    CommentButton(postViewModel: postViewModel, showComments: $showComments)

                }
            }
            .opacity(isRotated ? 0 : 1)
=======

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
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee
        }
    }
}

<<<<<<< HEAD
let mockPostViewModel = PostViewModel(post: SampleData.emmaImagePost, currentUser: SampleData.userJohn)
=======
let mockPostViewModel = PostViewModel(post: textPost, currentUser: User(id: UUID(), username: "Current User", profilePicture: "placeholderImage", following: [], followers: [], lurking: 100, status: .default, acquiredThemes: [], selectedTheme: ThemeContent(id: UUID(), name: "Sample Theme", content: Theme(themeURL: "placeholderImage"), price: 0.0, creationDate: Date(), approved: true), dateJoined: Date(), location: "Unknown"))
>>>>>>> 85b11f88b2b101550951597502aaa4378ff9e7ee

#Preview {
    @Namespace var namespace

    return PopupPostView(postViewModel: mockPostViewModel, namespace: namespace, onDismiss: {})
}
